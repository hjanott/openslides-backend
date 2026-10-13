-- REMOVE SECTION --
-- DROP TABLE assignment_candidate_t CASCADE;
ALTER TABLE meeting_t DROP COLUMN external_id CASCADE;
ALTER TABLE motion_submitter_t DROP COLUMN meeting_user_id CASCADE;
ALTER TABLE poll_t DROP COLUMN pollmethod CASCADE;
DROP TYPE enum_poll_pollmethod;
DROP TABLE gm_organization_tag_tagged_ids_t CASCADE;
DROP TRIGGER equal_meeting_id_on_assignment_candidate_t_assignment_id ON assignment_candidate_t;
DROP TRIGGER equal_meeting_id_on_assignment_t_candidate_ids ON assignment_t;
DROP TRIGGER equal_meeting_id_on_assignment_candidate_t_meeting_user_id ON assignment_candidate_t;
DROP TRIGGER equal_meeting_id_on_meeting_user_t_assignment_candidate_ids ON meeting_user_t;

-- RENAME SECTION --
ALTER TYPE enum_poll_backends RENAME TO enum_atü;
-- drop intermediate tables
DROP TABLE gm_meeting_mediafile_attachment_ids_t CASCADE;

CREATE TABLE gm_meeting_mediafile_attachment_idss_t (
    meeting_mediafile_id integer
        CONSTRAINT required_gm_meeting_mediafile_attachment_idss_t_meeting_e7137b8 NOT NULL
        CONSTRAINT fk_gm_meeting_mediafile_attachment_idss_t_meeting_mediaf923aad3 REFERENCES meeting_mediafile_t(id)
        ON DELETE CASCADE
        INITIALLY DEFERRED,
    attachment_ids varchar(100)
        CONSTRAINT required_gm_meeting_mediafile_attachment_idss_t_attachment_ids NOT NULL,
    attachment_ids_motion_id integer
        CONSTRAINT generated_always_as_meeting_mediafile_attachment_ids GENERATED ALWAYS AS (CASE WHEN split_part(attachment_ids, '/', 1) = 'motion' THEN cast(split_part(attachment_ids, '/', 2) AS INTEGER) ELSE null END) STORED
        CONSTRAINT fk_gm_meeting_mediafile_attachment_idss_t_attachment_idsabfe3a2 REFERENCES motion_t(id)
        ON DELETE CASCADE
        INITIALLY DEFERRED,
    attachment_ids_topic_id integer
        CONSTRAINT generated_always_as_meeting_mediafile_attachment_ids GENERATED ALWAYS AS (CASE WHEN split_part(attachment_ids, '/', 1) = 'topic' THEN cast(split_part(attachment_ids, '/', 2) AS INTEGER) ELSE null END) STORED
        CONSTRAINT fk_gm_meeting_mediafile_attachment_idss_t_attachment_idsb3cab5a REFERENCES topic_t(id)
        ON DELETE CASCADE
        INITIALLY DEFERRED,
    attachment_ids_assignment_id integer
        CONSTRAINT generated_always_as_meeting_mediafile_attachment_ids GENERATED ALWAYS AS (CASE WHEN split_part(attachment_ids, '/', 1) = 'assignment' THEN cast(split_part(attachment_ids, '/', 2) AS INTEGER) ELSE null END) STORED
        CONSTRAINT fk_gm_meeting_mediafile_attachment_idss_t_attachment_ids4cd13ae REFERENCES assignment_t(id)
        ON DELETE CASCADE
        INITIALLY DEFERRED,
    CONSTRAINT valid_meeting_mediafile_attachment_ids_part1 CHECK (split_part(attachment_ids, '/', 1) IN ('motion', 'topic', 'assignment')),
    CONSTRAINT unique_meeting_mediafile_id_attachment_ids UNIQUE (meeting_mediafile_id, attachment_ids)
);
CREATE INDEX idx_gm_meeting_mediafile_attachment_idss_t_meeting_mediafile_id ON gm_meeting_mediafile_attachment_idss_t (meeting_mediafile_id);
CREATE INDEX idx_gm_meeting_mediafile_attachment_idss_t_attachment_ids ON gm_meeting_mediafile_attachment_idss_t (attachment_ids);
CREATE INDEX idx_gm_meeting_mediafile_attachment_idss_t_attachment_id030368d ON gm_meeting_mediafile_attachment_idss_t (attachment_ids_motion_id);
CREATE INDEX idx_gm_meeting_mediafile_attachment_idss_t_attachment_id45f4cfb ON gm_meeting_mediafile_attachment_idss_t (attachment_ids_topic_id);
CREATE INDEX idx_gm_meeting_mediafile_attachment_idss_t_attachment_id51587d7 ON gm_meeting_mediafile_attachment_idss_t (attachment_ids_assignment_id);

DROP TABLE nm_group_poll_ids_poll_t CASCADE;

CREATE TABLE nm_group_poll_idss_poll_t (
    group_id integer
        CONSTRAINT required_nm_group_poll_idss_poll_t_group_id NOT NULL
        CONSTRAINT fk_nm_group_poll_idss_poll_t_group_id_group_t_id REFERENCES group_t (id)
        ON DELETE CASCADE
        INITIALLY DEFERRED,
    poll_id integer
        CONSTRAINT required_nm_group_poll_idss_poll_t_poll_id NOT NULL
        CONSTRAINT fk_nm_group_poll_idss_poll_t_poll_id_poll_t_id REFERENCES poll_t (id)
        ON DELETE CASCADE
        INITIALLY DEFERRED,
    CONSTRAINT pk_nm_group_poll_idss_poll_t PRIMARY KEY (group_id, poll_id)
);
CREATE INDEX idx_nm_group_poll_idss_poll_t_group_id ON nm_group_poll_idss_poll_t (group_id);
CREATE INDEX idx_nm_group_poll_idss_poll_t_poll_id ON nm_group_poll_idss_poll_t (poll_id);


ALTER TABLE organization_t RENAME TO chaos_t;
ALTER VIEW "organization" RENAME TO chaos;
ALTER INDEX idx_organization_t_theme_id RENAME TO idx_chaos_t_theme_id;
ALTER TABLE chaos_t RENAME CONSTRAINT fk_organization_t_theme_id_theme_t_id TO fk_chaos_t_theme_id_theme_t_id;
ALTER TRIGGER tr_log_organization_t_theme_id ON chaos_t RENAME TO tr_log_chaos_t_theme_id;
ALTER TABLE chaos_t RENAME CONSTRAINT minimum_organization_limit_of_meetings TO minimum_chaos_limit_of_meetings;
ALTER TABLE chaos_t RENAME CONSTRAINT minimum_organization_limit_of_users TO minimum_chaos_limit_of_users;
ALTER TABLE chaos_t RENAME CONSTRAINT timezone_organization_time_zone TO timezone_chaos_time_zone;
ALTER TABLE chaos_t RENAME CONSTRAINT unique_organization_theme_id TO unique_chaos_theme_id;
-- ALTER TYPE enum_meeting_motions_assignments_number_type RENAME TO enum_meeting_motions_number_type;
-- ALTER VIEW "meeting" RENAME COLUMN motions_number_type TO motions_assignments_number_type;
ALTER TABLE meeting_t RENAME COLUMN motions_number_type TO motions_assignments_number_type;
-- ALTER VIEW "meeting" RENAME COLUMN group_ids TO agroupzzz;
ALTER TABLE meeting_t RENAME CONSTRAINT unique_meeting_motions_default_amendment_workflow_id TO unique_meeting_motions_default_amendment_workflow_iddd;
-- ALTER VIEW "meeting" RENAME COLUMN motions_default_amendment_workflow_id TO motions_default_amendment_workflow_iddd;
ALTER TABLE meeting_t RENAME COLUMN motions_default_amendment_workflow_id TO motions_default_amendment_workflow_iddd;
ALTER INDEX idx_meeting_t_motions_default_amendment_workflow_id RENAME TO idx_meeting_t_motions_default_amendment_workflow_iddd;
ALTER TABLE meeting_t RENAME CONSTRAINT fk_meeting_t_motions_default_amendment_workflow_id_motio34ae2bf TO fk_meeting_t_motions_default_amendment_workflow_iddd_motc9198ad;
ALTER TRIGGER tr_log_meeting_t_motions_default_amendment_workflow_id ON meeting_t RENAME TO tr_log_meeting_t_motions_default_amendment_workflow_iddd;
-- ALTER VIEW "meeting_mediafile" RENAME COLUMN attachment_ids TO attachment_idss;
-- ALTER TRIGGER tr_log_attachment_id_motion_id_gm_meeting_mediafile_atta25df47a ON meeting_mediafile_t RENAME TO tr_log_attachment_ids_motion_id_gm_meeting_mediafile_att3351206;
-- ALTER VIEW "group" RENAME COLUMN poll_ids TO poll_idss;
-- ALTER TRIGGER tr_log_nm_group_poll_ids_poll_t ON group_t RENAME TO tr_log_nm_group_poll_idss_poll_t;
-- DROP TRIGGER equal_meeting_id_on_group_t_poll_ids ON group_t;
DROP TRIGGER equal_meeting_id_on_poll_t_entitled_group_ids ON poll_t;

CREATE CONSTRAINT TRIGGER equal_meeting_id_on_group_t_poll_idss AFTER INSERT OR UPDATE OF meeting_id ON group_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_multi('nm_group_poll_idss_poll_t', 'group_id', 'group', 'poll_id', 'poll', 'meeting_id', 'poll_idss');
CREATE CONSTRAINT TRIGGER equal_meeting_id_on_poll_t_entitled_group_ids AFTER INSERT ON poll_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_multi('nm_group_poll_idss_poll_t', 'poll_id', 'poll', 'group_id', 'group', 'meeting_id', 'entitled_group_ids');
CREATE CONSTRAINT TRIGGER equal_meeting_id_on_group_t_poll_idss_intermediate AFTER INSERT ON nm_group_poll_idss_poll_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_intermediate('group_id', 'group', 'poll_id', 'poll', 'meeting_id', 'poll_idss');


-- ADD SECTION --
CREATE TABLE assignment_category_t (
    id integer PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    name varchar(256)
        CONSTRAINT required_assignment_category_name NOT NULL,
    prefix varchar(256),
    weight integer
        CONSTRAINT default_assignment_category_weight DEFAULT 10000,
    level integer,
    sequential_number integer
        CONSTRAINT required_assignment_category_sequential_number NOT NULL,
    CONSTRAINT unique_assignment_category_sequential_number_meeting_id UNIQUE (sequential_number, meeting_id),
    parent_id integer,
    meeting_id integer
        CONSTRAINT required_assignment_category_meeting_id NOT NULL
);



comment on column assignment_category_t.level is 'Calculated field.';
comment on column assignment_category_t.sequential_number is 'The (positive) serial number of this model in its meeting. This number is auto-generated and read-only.';

ALTER TABLE assignment_category_t ADD CONSTRAINT fk_assignment_category_t_parent_id_assignment_category_t_id FOREIGN KEY(parent_id) REFERENCES assignment_category_t(id) INITIALLY DEFERRED;
CREATE INDEX idx_assignment_category_t_parent_id ON assignment_category_t (parent_id);
ALTER TABLE assignment_category_t ADD CONSTRAINT fk_assignment_category_t_meeting_id_meeting_t_id FOREIGN KEY(meeting_id) REFERENCES meeting_t(id) INITIALLY DEFERRED;
CREATE INDEX idx_assignment_category_t_meeting_id ON assignment_category_t (meeting_id);


-- definition trigger prevent_updates for assignment_category.sequential_number
CREATE TRIGGER tr_constant_assignment_category_sequential_number BEFORE UPDATE OF sequential_number ON assignment_category_t
FOR EACH ROW EXECUTE FUNCTION prevent_updates('assignment_category', 'sequential_number');

-- definition trigger generate partitioned sequence number for assignment_category_t.sequential_number partitioned by meeting_id
CREATE TRIGGER tr_generate_sequence_assignment_category_sequential_number BEFORE INSERT ON assignment_category_t
FOR EACH ROW EXECUTE FUNCTION generate_sequence('assignment_category_t', 'sequential_number', 'meeting_id');

CREATE CONSTRAINT TRIGGER equal_meeting_id_on_assignment_category_t_parent_id AFTER INSERT OR UPDATE OF parent_id ON assignment_category_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals('assignment_category', 'assignment_category', 'parent_id', 'meeting_id', FALSE);
CREATE CONSTRAINT TRIGGER equal_meeting_id_on_assignment_category_t_child_ids AFTER INSERT ON assignment_category_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals('assignment_category', 'assignment_category', 'parent_id', 'meeting_id', TRUE);

CREATE TRIGGER tr_log_assignment_category_t_parent_id AFTER INSERT OR UPDATE OF parent_id OR DELETE ON assignment_category_t
FOR EACH ROW EXECUTE FUNCTION log_modified_related_models('assignment_category', 'parent_id', 'child_ids');

-- definition trigger prevent_updates for assignment_category.meeting_id
CREATE TRIGGER tr_constant_assignment_category_meeting_id BEFORE UPDATE OF meeting_id ON assignment_category_t
FOR EACH ROW EXECUTE FUNCTION prevent_updates('assignment_category', 'meeting_id');
CREATE TRIGGER tr_log_assignment_category_t_meeting_id AFTER INSERT OR UPDATE OF meeting_id OR DELETE ON assignment_category_t
FOR EACH ROW EXECUTE FUNCTION log_modified_related_models('meeting', 'meeting_id', 'assignment_category_ids');
ALTER TABLE assignment_t ADD COLUMN category_id integer;
ALTER TABLE assignment_t ADD COLUMN meeting_idd integer
        CONSTRAINT required_assignment_t_meeting_idd NOT NULL;
ALTER TABLE meeting_t ADD COLUMN assignment_category_ids integer;
ALTER TABLE meeting_t ADD COLUMN default_meeting_for_committee_idd integer;
ALTER TABLE meeting_t ALTER COLUMN motions_enable_restricted_editor_for_non_manager SET DEFAULT True;
ALTER TABLE motion_submitter_t ADD COLUMN meeting_user_idd integer;
ALTER TABLE motion_workflow_t ADD COLUMN meeting_idd integer
        CONSTRAINT required_motion_workflow_t_meeting_idd NOT NULL;
ALTER TABLE organization_tag_t ADD COLUMN org_tagged_ids integer;

-- EDIT SECTION --
ALTER TYPE enum_languages ADD VALUE 'ir';
ALTER TABLE agenda_item_t ALTER COLUMN type SET DEFAULT 'internal';
ALTER TABLE agenda_item_t ALTER COLUMN content_object_id SET NOT NULL;
ALTER TABLE assignment_t ALTER COLUMN title DROP NOT NULL;
DROP TRIGGER tr_i_not_null_assignment_list_of_speakers_id ON assignment_t;
DROP TRIGGER tr_ud_not_null_assignment_list_of_speakers_id ON list_of_speakers_t;
ALTER TYPE enum_group_permissions RENAME VALUE 'assignment.can_manage_polls' TO 'assignment.can_manage_pollsd';
-- DROP TRIGGER tr_constant_group_t_meeting_id ON group_t;
ALTER TABLE list_of_speakers_t ALTER COLUMN content_object_id SET NOT NULL;
ALTER TABLE meeting_t DROP CONSTRAINT maximum_meeting_export_pdf_fontsize;
ALTER TABLE meeting_t ADD CONSTRAINT maximum_meeting_export_pdf_fontsize CHECK (export_pdf_fontsize <= 123);
DROP VIEW IF EXISTS "meeting";
ALTER TABLE meeting_t ALTER COLUMN motion_poll_ballot_paper_selection TYPE text;
ALTER TABLE meeting_t ALTER COLUMN motion_poll_ballot_paper_selection DROP DEFAULT;
ALTER TABLE meeting_t ALTER COLUMN poll_ballot_paper_selection TYPE text;

-- definition trigger not null for meeting_user.group_ids against group.meeting_user_ids through nm_group_meeting_user_ids_meeting_user_t
DROP TRIGGER tr_i_not_null_meeting_user_group_ids ON meeting_user_t;
CREATE CONSTRAINT TRIGGER tr_i_not_null_meeting_user_group_ids AFTER INSERT ON meeting_user_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_not_null_for_n_m('nm_group_meeting_user_ids_meeting_user_t', 'meeting_user_t', 'group_ids', 'meeting_user_id');

DROP TRIGGER tr_d_not_null_meeting_user_group_ids ON nm_group_meeting_user_ids_meeting_user_t;
CREATE CONSTRAINT TRIGGER tr_d_not_null_meeting_user_group_ids AFTER DELETE ON nm_group_meeting_user_ids_meeting_user_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_not_null_for_n_m('nm_group_meeting_user_ids_meeting_user_t', 'meeting_user_t', 'group_ids', 'meeting_user_id', 'group_id', 'group', 'meeting_user_ids');

ALTER TYPE enum_poll_state ADD VALUE 'fdf';
ALTER TABLE poll_t DROP CONSTRAINT minimum_poll_min_votes_amount;
ALTER TABLE poll_t ADD CONSTRAINT minimum_poll_min_votes_amount CHECK (min_votes_amount >= 2);
DROP VIEW IF EXISTS "poll";
ALTER TABLE poll_t ALTER COLUMN onehundred_percent_base TYPE text;
ALTER TABLE poll_t ALTER COLUMN onehundred_percent_base DROP DEFAULT;
ALTER TABLE poll_t ALTER COLUMN content_object_id SET NOT NULL;
ALTER TABLE poll_t ALTER COLUMN meeting_id SET NOT NULL;
DROP TRIGGER equal_meeting_id_on_meeting_mediafile_t_attachment_ids_a02016b9 ON meeting_mediafile_t;
DROP TRIGGER equal_meeting_id_on_assignment_t_attachment_meeting_media9bbdf7 ON assignment_t;
DROP TRIGGER equal_meeting_id_on_meeting_mediafile_t_attachment_ids_motion_t ON meeting_mediafile_t;
DROP TRIGGER equal_meeting_id_on_motion_t_attachment_meeting_mediafile_ids ON motion_t;
DROP TRIGGER equal_meeting_id_on_meeting_mediafile_t_attachment_ids_topic_t ON meeting_mediafile_t;
DROP TRIGGER equal_meeting_id_on_topic_t_attachment_meeting_mediafile_ids ON topic_t;
-- DROP TRIGGER equal_meeting_id_on_motion_workflow_t_generic_generic_fi7abcb7f ON motion_workflow_t;
-- DROP TRIGGER equal_meeting_id_on_assignment_t_generic_generic_field ON assignment_t;
-- DROP TRIGGER equal_meeting_id_on_motion_workflow_t_generic_generic_fieda34ba ON gm_motion_workflow_generic_generic_field_t;
-- DROP TRIGGER equal_meeting_id_on_motion_submitter_t_meeting_user_id ON motion_submitter_t;
DROP TRIGGER equal_meeting_id_on_meeting_user_t_motion_submitter_ids ON meeting_user_t;

CREATE CONSTRAINT TRIGGER equal_meeting_id_on_meeting_mediafile_t_attachment_idss_5f191ac AFTER INSERT ON meeting_mediafile_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_multi('gm_meeting_mediafile_attachment_idss_t', 'meeting_mediafile_id', 'meeting_mediafile', 'attachment_ids_motion_id', 'motion', 'meeting_id', 'attachment_idss');
CREATE CONSTRAINT TRIGGER equal_meeting_id_on_motion_t_attachment_meeting_mediafile_ids AFTER INSERT ON motion_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_multi('gm_meeting_mediafile_attachment_idss_t', 'attachment_ids_motion_id', 'motion', 'meeting_mediafile_id', 'meeting_mediafile', 'meeting_id', 'attachment_meeting_mediafile_ids');
CREATE CONSTRAINT TRIGGER equal_meeting_id_on_meeting_mediafile_t_attachment_idss_8017b3e AFTER INSERT ON gm_meeting_mediafile_attachment_idss_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_intermediate('meeting_mediafile_id', 'meeting_mediafile', 'attachment_ids_motion_id', 'motion', 'meeting_id', 'attachment_idss');


CREATE CONSTRAINT TRIGGER equal_meeting_id_on_meeting_mediafile_t_attachment_idss_topic_t AFTER INSERT ON meeting_mediafile_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_multi('gm_meeting_mediafile_attachment_idss_t', 'meeting_mediafile_id', 'meeting_mediafile', 'attachment_ids_topic_id', 'topic', 'meeting_id', 'attachment_idss');
CREATE CONSTRAINT TRIGGER equal_meeting_id_on_topic_t_attachment_meeting_mediafile_ids AFTER INSERT ON topic_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_multi('gm_meeting_mediafile_attachment_idss_t', 'attachment_ids_topic_id', 'topic', 'meeting_mediafile_id', 'meeting_mediafile', 'meeting_id', 'attachment_meeting_mediafile_ids');
CREATE CONSTRAINT TRIGGER equal_meeting_id_on_meeting_mediafile_t_attachment_idss_2b69a29 AFTER INSERT ON gm_meeting_mediafile_attachment_idss_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_intermediate('meeting_mediafile_id', 'meeting_mediafile', 'attachment_ids_topic_id', 'topic', 'meeting_id', 'attachment_idss');


CREATE CONSTRAINT TRIGGER equal_meeting_id_on_meeting_mediafile_t_attachment_idss_4dbf1c2 AFTER INSERT ON meeting_mediafile_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_multi('gm_meeting_mediafile_attachment_idss_t', 'meeting_mediafile_id', 'meeting_mediafile', 'attachment_ids_assignment_id', 'assignment', 'meeting_id', 'attachment_idss');
CREATE CONSTRAINT TRIGGER equal_meeting_id_on_assignment_t_attachment_meeting_media9bbdf7 AFTER INSERT ON assignment_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_multi('gm_meeting_mediafile_attachment_idss_t', 'attachment_ids_assignment_id', 'assignment', 'meeting_mediafile_id', 'meeting_mediafile', 'meeting_id', 'attachment_meeting_mediafile_ids');
CREATE CONSTRAINT TRIGGER equal_meeting_id_on_meeting_mediafile_t_attachment_idss_43de278 AFTER INSERT ON gm_meeting_mediafile_attachment_idss_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals_intermediate('meeting_mediafile_id', 'meeting_mediafile', 'attachment_ids_assignment_id', 'assignment', 'meeting_id', 'attachment_idss');


-- CREATE CONSTRAINT TRIGGER equal_meeting_id_on_motion_workflow_t_generic_generic_fi7abcb7f AFTER INSERT ON motion_workflow_t INITIALLY DEFERRED
-- FOR EACH ROW EXECUTE FUNCTION check_equals_multi('gm_motion_workflow_generic_generic_field_t', 'motion_workflow_id', 'motion_workflow', 'generic_generic_fiel_assignment_id', 'assignment', 'meeting_id', 'generic_generic_field');
-- CREATE CONSTRAINT TRIGGER equal_meeting_id_on_assignment_t_generic_generic_field AFTER INSERT ON assignment_t INITIALLY DEFERRED
-- FOR EACH ROW EXECUTE FUNCTION check_equals_multi('gm_motion_workflow_generic_generic_field_t', 'generic_generic_fiel_assignment_id', 'assignment', 'motion_workflow_id', 'motion_workflow', 'meeting_id', 'generic_generic_field');
-- CREATE CONSTRAINT TRIGGER equal_meeting_id_on_motion_workflow_t_generic_generic_fieda34ba AFTER INSERT ON gm_motion_workflow_generic_generic_field_t INITIALLY DEFERRED
-- FOR EACH ROW EXECUTE FUNCTION check_equals_intermediate('motion_workflow_id', 'motion_workflow', 'generic_generic_fiel_assignment_id', 'assignment', 'meeting_id', 'generic_generic_field');


-- CREATE CONSTRAINT TRIGGER equal_meeting_idd_on_motion_workflow_t_generic_generic_f838d9d8 AFTER INSERT ON motion_workflow_t INITIALLY DEFERRED
-- FOR EACH ROW EXECUTE FUNCTION check_equals_multi('gm_motion_workflow_generic_generic_field_t', 'motion_workflow_id', 'motion_workflow', 'generic_generic_fiel_assignment_id', 'assignment', 'meeting_idd', 'generic_generic_field');
-- CREATE CONSTRAINT TRIGGER equal_meeting_idd_on_assignment_t_generic_generic_field AFTER INSERT ON assignment_t INITIALLY DEFERRED
-- FOR EACH ROW EXECUTE FUNCTION check_equals_multi('gm_motion_workflow_generic_generic_field_t', 'generic_generic_fiel_assignment_id', 'assignment', 'motion_workflow_id', 'motion_workflow', 'meeting_idd', 'generic_generic_field');
-- CREATE CONSTRAINT TRIGGER equal_meeting_idd_on_motion_workflow_t_generic_generic_fdd7a2fe AFTER INSERT ON gm_motion_workflow_generic_generic_field_t INITIALLY DEFERRED
-- FOR EACH ROW EXECUTE FUNCTION check_equals_intermediate('motion_workflow_id', 'motion_workflow', 'generic_generic_fiel_assignment_id', 'assignment', 'meeting_idd', 'generic_generic_field');


CREATE CONSTRAINT TRIGGER equal_meeting_id_on_motion_submitter_t_meeting_user_idd AFTER INSERT OR UPDATE OF meeting_user_idd ON motion_submitter_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals('motion_submitter', 'meeting_user', 'meeting_user_idd', 'meeting_id', FALSE);
CREATE CONSTRAINT TRIGGER equal_meeting_id_on_meeting_user_t_motion_submitter_ids AFTER INSERT ON meeting_user_t INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION check_equals('motion_submitter', 'meeting_user', 'meeting_user_idd', 'meeting_id', TRUE);


-- VIEWS UPDATE SECTION --
DROP VIEW IF EXISTS "assignment";

CREATE VIEW "assignment" AS SELECT *,
(select array_agg(p.id ORDER BY p.id) from poll_t p where p.content_object_id_assignment_id = a.id) as poll_ids,
(select ai.id from agenda_item_t ai where ai.content_object_id_assignment_id = a.id) as agenda_item_id,
(select l.id from list_of_speakers_t l where l.content_object_id_assignment_id = a.id) as list_of_speakers_id,
(select array_agg(g.tag_id ORDER BY g.tag_id) from gm_tag_tagged_ids_t g where g.tagged_id_assignment_id = a.id) as tag_ids,
(select array_agg(g.meeting_mediafile_id ORDER BY g.meeting_mediafile_id) from gm_meeting_mediafile_attachment_idss_t g where g.attachment_ids_assignment_id = a.id) as attachment_meeting_mediafile_ids,
(select array_agg(p.id ORDER BY p.id) from projection_t p where p.content_object_id_assignment_id = a.id) as projection_ids,
-- (select array_agg(g.motion_workflow_id ORDER BY g.motion_workflow_id) from gm_motion_workflow_generic_generic_field_t g where g.generic_generic_fiel_assignment_id = a.id) as generic_generic_field,
(select array_agg(h.id ORDER BY h.id) from history_entry_t h where h.model_id_assignment_id = a.id) as history_entry_ids
FROM assignment_t a;

DROP VIEW IF EXISTS "assignment_category";

CREATE VIEW "assignment_category" AS SELECT *,
(select array_agg(ac.id ORDER BY ac.id) from assignment_category_t ac where ac.parent_id = a.id) as child_ids,
(select array_agg(at.id ORDER BY at.id) from assignment_t at where at.category_id = a.id) as assignment_ids
FROM assignment_category_t a;

DROP VIEW IF EXISTS "committee";

CREATE VIEW "committee" AS SELECT *,
(select array_agg(m.id ORDER BY m.id) from meeting_t m where m.committee_id = c.id) as meeting_ids,
(
  SELECT array_agg(DISTINCT user_id ORDER BY user_id)
  FROM (
    -- Select user_ids from committees meetings
    SELECT mu.user_id
    FROM meeting_t AS m
    INNER JOIN meeting_user_t AS mu ON mu.meeting_id = m.id
    WHERE m.committee_id = c.id

    UNION

    -- Select user_ids from committee managers
    SELECT cmu.user_id
    FROM nm_committee_manager_ids_user_t cmu
    WHERE cmu.committee_id = c.id

    UNION

    -- Select user_id from home committees
    SELECT u.id
    FROM user_t u
    WHERE u.home_committee_id = c.id
  ) _
) AS user_ids
,
(select array_agg(n.user_id ORDER BY n.user_id) from nm_committee_manager_ids_user_t n where n.committee_id = c.id) as manager_ids,
(select array_agg(ct.id ORDER BY ct.id) from committee_t ct where ct.parent_id = c.id) as child_ids,
(select array_agg(n.all_parent_id ORDER BY n.all_parent_id) from nm_committee_all_child_ids_committee_t n where n.all_child_id = c.id) as all_parent_ids,
(select array_agg(n.all_child_id ORDER BY n.all_child_id) from nm_committee_all_child_ids_committee_t n where n.all_parent_id = c.id) as all_child_ids,
(select array_agg(u.id ORDER BY u.id) from user_t u where u.home_committee_id = c.id) as native_user_ids,
(select array_agg(n.forward_to_committee_id ORDER BY n.forward_to_committee_id) from nm_committee_forward_to_committee_ids_committee_t n where n.receive_forwardings_from_committee_id = c.id) as forward_to_committee_ids,
(select array_agg(n.receive_forwardings_from_committee_id ORDER BY n.receive_forwardings_from_committee_id) from nm_committee_forward_to_committee_ids_committee_t n where n.forward_to_committee_id = c.id) as receive_forwardings_from_committee_ids
-- (select array_agg(g.organization_tag_id ORDER BY g.organization_tag_id) from gm_organization_tag_org_tagged_ids_t g where g.org_tagged_id_committee_id = c.id) as organization_tag_ids
FROM committee_t c;

comment on column "committee".user_ids is 'Calculated field: All users which are in a group of a meeting, belonging to the committee or beeing manager of the committee';

CREATE VIEW "meeting" AS SELECT *,
(select array_agg(g.id ORDER BY g.id) from group_t g where g.used_as_motion_poll_default_id = m.id) as motion_poll_default_group_ids,
(select array_agg(p.id ORDER BY p.id) from poll_candidate_list_t p where p.meeting_id = m.id) as poll_candidate_list_ids,
(select array_agg(p.id ORDER BY p.id) from poll_candidate_t p where p.meeting_id = m.id) as poll_candidate_ids,
(select array_agg(mu.id ORDER BY mu.id) from meeting_user_t mu where mu.meeting_id = m.id) as meeting_user_ids,
(select array_agg(g.id ORDER BY g.id) from group_t g where g.used_as_assignment_poll_default_id = m.id) as assignment_poll_default_group_ids,
(select array_agg(g.id ORDER BY g.id) from group_t g where g.used_as_poll_default_id = m.id) as poll_default_group_ids,
(select array_agg(g.id ORDER BY g.id) from group_t g where g.used_as_topic_poll_default_id = m.id) as topic_poll_default_group_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.meeting_id = m.id) as projector_ids,
(select array_agg(p.id ORDER BY p.id) from projection_t p where p.meeting_id = m.id) as all_projection_ids,
(select array_agg(p.id ORDER BY p.id) from projector_message_t p where p.meeting_id = m.id) as projector_message_ids,
(select array_agg(p.id ORDER BY p.id) from projector_countdown_t p where p.meeting_id = m.id) as projector_countdown_ids,
(select array_agg(t.id ORDER BY t.id) from tag_t t where t.meeting_id = m.id) as tag_ids,
(select array_agg(a.id ORDER BY a.id) from agenda_item_t a where a.meeting_id = m.id) as agenda_item_ids,
(select array_agg(l.id ORDER BY l.id) from list_of_speakers_t l where l.meeting_id = m.id) as list_of_speakers_ids,
(select array_agg(s.id ORDER BY s.id) from structure_level_list_of_speakers_t s where s.meeting_id = m.id) as structure_level_list_of_speakers_ids,
(select array_agg(p.id ORDER BY p.id) from point_of_order_category_t p where p.meeting_id = m.id) as point_of_order_category_ids,
(select array_agg(s.id ORDER BY s.id) from speaker_t s where s.meeting_id = m.id) as speaker_ids,
(select array_agg(t.id ORDER BY t.id) from topic_t t where t.meeting_id = m.id) as topic_ids,
(select array_agg(g.id ORDER BY g.id) from group_t g where g.meeting_id = m.id) as agroupzzz,
(select array_agg(mm.id ORDER BY mm.id) from meeting_mediafile_t mm where mm.meeting_id = m.id) as meeting_mediafile_ids,
(select array_agg(mt.id ORDER BY mt.id) from mediafile_t mt where mt.owner_id_meeting_id = m.id) as mediafile_ids,
(select array_agg(mt.id ORDER BY mt.id) from motion_t mt where mt.meeting_id = m.id) as motion_ids,
(select array_agg(mt.id ORDER BY mt.id) from motion_t mt where mt.origin_meeting_id = m.id) as forwarded_motion_ids,
(select array_agg(mc.id ORDER BY mc.id) from motion_comment_section_t mc where mc.meeting_id = m.id) as motion_comment_section_ids,
(select array_agg(mc.id ORDER BY mc.id) from motion_category_t mc where mc.meeting_id = m.id) as motion_category_ids,
-- (select array_agg(a.id ORDER BY a.id) from assignment_category_t a where a.meeting_id = m.id) as assignment_category_ids,
(select array_agg(mb.id ORDER BY mb.id) from motion_block_t mb where mb.meeting_id = m.id) as motion_block_ids,
(select array_agg(mw.id ORDER BY mw.id) from motion_workflow_t mw where mw.meeting_id = m.id) as motion_workflow_ids,
(select array_agg(mc.id ORDER BY mc.id) from motion_comment_t mc where mc.meeting_id = m.id) as motion_comment_ids,
(select array_agg(ms.id ORDER BY ms.id) from motion_submitter_t ms where ms.meeting_id = m.id) as motion_submitter_ids,
(select array_agg(ms.id ORDER BY ms.id) from motion_supporter_t ms where ms.meeting_id = m.id) as motion_supporter_ids,
(select array_agg(me.id ORDER BY me.id) from motion_editor_t me where me.meeting_id = m.id) as motion_editor_ids,
(select array_agg(mw.id ORDER BY mw.id) from motion_working_group_speaker_t mw where mw.meeting_id = m.id) as motion_working_group_speaker_ids,
(select array_agg(mc.id ORDER BY mc.id) from motion_change_recommendation_t mc where mc.meeting_id = m.id) as motion_change_recommendation_ids,
(select array_agg(ms.id ORDER BY ms.id) from motion_state_t ms where ms.meeting_id = m.id) as motion_state_ids,
(select array_agg(p.id ORDER BY p.id) from poll_t p where p.meeting_id = m.id) as poll_ids,
(select array_agg(o.id ORDER BY o.id) from option_t o where o.meeting_id = m.id) as option_ids,
(select array_agg(v.id ORDER BY v.id) from vote_t v where v.meeting_id = m.id) as vote_ids,
(select array_agg(a.id ORDER BY a.id) from assignment_t a where a.meeting_id = m.id) as assignment_ids,
(select array_agg(p.id ORDER BY p.id) from personal_note_t p where p.meeting_id = m.id) as personal_note_ids,
(select array_agg(c.id ORDER BY c.id) from chat_group_t c where c.meeting_id = m.id) as chat_group_ids,
(select array_agg(c.id ORDER BY c.id) from chat_message_t c where c.meeting_id = m.id) as chat_message_ids,
(select array_agg(s.id ORDER BY s.id) from structure_level_t s where s.meeting_id = m.id) as structure_level_ids,
-- (select c.id from committee_t c where c.default_meeting_id = m.id) as default_meeting_for_committee_idd,
-- (select array_agg(g.organization_tag_id ORDER BY g.organization_tag_id) from gm_organization_tag_org_tagged_ids_t g where g.org_tagged_id_meeting_id = m.id) as organization_tag_ids,
(select array_agg(n.user_id ORDER BY n.user_id) from nm_meeting_present_user_ids_user_t n where n.meeting_id = m.id) as present_user_ids,
(
  SELECT array_agg(DISTINCT mu.user_id ORDER BY mu.user_id)
  FROM meeting_user_t mu
  WHERE mu.meeting_id = m.id
) AS user_ids
,
(select array_agg(p.id ORDER BY p.id) from projection_t p where p.content_object_id_meeting_id = m.id) as projection_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_agenda_item_list_in_meeting_id = m.id) as default_projector_agenda_item_list_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_topic_in_meeting_id = m.id) as default_projector_topic_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_list_of_speakers_in_meeting_id = m.id) as default_projector_list_of_speakers_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_current_los_in_meeting_id = m.id) as default_projector_current_los_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_motion_in_meeting_id = m.id) as default_projector_motion_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_amendment_in_meeting_id = m.id) as default_projector_amendment_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_motion_block_in_meeting_id = m.id) as default_projector_motion_block_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_assignment_in_meeting_id = m.id) as default_projector_assignment_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_mediafile_in_meeting_id = m.id) as default_projector_mediafile_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_message_in_meeting_id = m.id) as default_projector_message_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_countdown_in_meeting_id = m.id) as default_projector_countdown_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_assignment_poll_in_meeting_id = m.id) as default_projector_assignment_poll_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_motion_poll_in_meeting_id = m.id) as default_projector_motion_poll_ids,
(select array_agg(p.id ORDER BY p.id) from projector_t p where p.used_as_default_projector_for_poll_in_meeting_id = m.id) as default_projector_poll_ids,
(select array_agg(h.id ORDER BY h.id) from history_entry_t h where h.meeting_id = m.id) as relevant_history_entry_ids
FROM meeting_t m;

comment on column "meeting".user_ids is 'Calculated. All user ids from all users assigned to groups of this meeting.';
DROP VIEW IF EXISTS "meeting_user";

CREATE VIEW "meeting_user" AS SELECT *,
(select array_agg(p.id ORDER BY p.id) from personal_note_t p where p.meeting_user_id = m.id) as personal_note_ids,
(select array_agg(s.id ORDER BY s.id) from speaker_t s where s.meeting_user_id = m.id) as speaker_ids,
(select array_agg(ms.id ORDER BY ms.id) from motion_supporter_t ms where ms.meeting_user_id = m.id) as motion_supporter_ids,
(select array_agg(me.id ORDER BY me.id) from motion_editor_t me where me.meeting_user_id = m.id) as motion_editor_ids,
(select array_agg(mw.id ORDER BY mw.id) from motion_working_group_speaker_t mw where mw.meeting_user_id = m.id) as motion_working_group_speaker_ids,
(select array_agg(ms.id ORDER BY ms.id) from motion_submitter_t ms where ms.meeting_user_idd = m.id) as motion_submitter_ids,
(select array_agg(mu.id ORDER BY mu.id) from meeting_user_t mu where mu.vote_delegated_to_id = m.id) as vote_delegations_from_ids,
(select array_agg(c.id ORDER BY c.id) from chat_message_t c where c.meeting_user_id = m.id) as chat_message_ids,
(select array_agg(n.group_id ORDER BY n.group_id) from nm_group_meeting_user_ids_meeting_user_t n where n.meeting_user_id = m.id) as group_ids,
(select array_agg(n.structure_level_id ORDER BY n.structure_level_id) from nm_meeting_user_structure_level_ids_structure_level_t n where n.meeting_user_id = m.id) as structure_level_ids
FROM meeting_user_t m;

DROP VIEW IF EXISTS "motion";

CREATE VIEW "motion" AS SELECT *,
(select array_agg(mt.id ORDER BY mt.id) from motion_t mt where mt.lead_motion_id = m.id) as amendment_ids,
(select array_agg(mt.id ORDER BY mt.id) from motion_t mt where mt.sort_parent_id = m.id) as sort_child_ids,
(select array_agg(mt.id ORDER BY mt.id) from motion_t mt where mt.origin_id = m.id) as derived_motion_ids,
(select array_agg(n.all_origin_id ORDER BY n.all_origin_id) from nm_motion_all_derived_motion_ids_motion_t n where n.all_derived_motion_id = m.id) as all_origin_ids,
(select array_agg(n.all_derived_motion_id ORDER BY n.all_derived_motion_id) from nm_motion_all_derived_motion_ids_motion_t n where n.all_origin_id = m.id) as all_derived_motion_ids,
(select array_cat((select array_agg(n.identical_motion_id_1 ORDER BY n.identical_motion_id_1) from nm_motion_identical_motion_ids_motion_t n where n.identical_motion_id_2 = m.id), (select array_agg(n.identical_motion_id_2 ORDER BY n.identical_motion_id_2) from nm_motion_identical_motion_ids_motion_t n where n.identical_motion_id_1 = m.id))) as identical_motion_ids,
(select array_agg(g.state_extension_reference_id ORDER BY g.state_extension_reference_id) from gm_motion_state_extension_reference_ids_t g where g.motion_id = m.id) as state_extension_reference_ids,
(select array_agg(g.motion_id ORDER BY g.motion_id) from gm_motion_state_extension_reference_ids_t g where g.state_extension_reference_id_motion_id = m.id) as referenced_in_motion_state_extension_ids,
(select array_agg(g.recommendation_extension_reference_id ORDER BY g.recommendation_extension_reference_id) from gm_motion_recommendation_extension_reference_ids_t g where g.motion_id = m.id) as recommendation_extension_reference_ids,
(select array_agg(g.motion_id ORDER BY g.motion_id) from gm_motion_recommendation_extension_reference_ids_t g where g.recommendation_extension_reference_id_motion_id = m.id) as referenced_in_motion_recommendation_extension_ids,
(select array_agg(ms.id ORDER BY ms.id) from motion_submitter_t ms where ms.motion_id = m.id) as submitter_ids,
(select array_agg(ms.id ORDER BY ms.id) from motion_supporter_t ms where ms.motion_id = m.id) as supporter_ids,
(select array_agg(me.id ORDER BY me.id) from motion_editor_t me where me.motion_id = m.id) as editor_ids,
(select array_agg(mw.id ORDER BY mw.id) from motion_working_group_speaker_t mw where mw.motion_id = m.id) as working_group_speaker_ids,
(select array_agg(p.id ORDER BY p.id) from poll_t p where p.content_object_id_motion_id = m.id) as poll_ids,
(select array_agg(o.id ORDER BY o.id) from option_t o where o.content_object_id_motion_id = m.id) as option_ids,
(select array_agg(mc.id ORDER BY mc.id) from motion_change_recommendation_t mc where mc.motion_id = m.id) as change_recommendation_ids,
(select array_agg(mc.id ORDER BY mc.id) from motion_comment_t mc where mc.motion_id = m.id) as comment_ids,
(select a.id from agenda_item_t a where a.content_object_id_motion_id = m.id) as agenda_item_id,
(select l.id from list_of_speakers_t l where l.content_object_id_motion_id = m.id) as list_of_speakers_id,
(select array_agg(g.tag_id ORDER BY g.tag_id) from gm_tag_tagged_ids_t g where g.tagged_id_motion_id = m.id) as tag_ids,
(select array_agg(g.meeting_mediafile_id ORDER BY g.meeting_mediafile_id) from gm_meeting_mediafile_attachment_idss_t g where g.attachment_ids_motion_id = m.id) as attachment_meeting_mediafile_ids,
(select array_agg(p.id ORDER BY p.id) from projection_t p where p.content_object_id_motion_id = m.id) as projection_ids,
(select array_agg(p.id ORDER BY p.id) from personal_note_t p where p.content_object_id_motion_id = m.id) as personal_note_ids,
(select array_agg(h.id ORDER BY h.id) from history_entry_t h where h.model_id_motion_id = m.id) as history_entry_ids
FROM motion_t m;

DROP VIEW IF EXISTS "motion_submitter";

CREATE VIEW "motion_submitter" AS SELECT * FROM motion_submitter_t m;

DROP VIEW IF EXISTS "motion_workflow";

CREATE VIEW "motion_workflow" AS SELECT *,
(select array_agg(ms.id ORDER BY ms.id) from motion_state_t ms where ms.workflow_id = m.id) as state_ids,
(select m1.id from meeting_t m1 where m1.motions_default_workflow_id = m.id) as default_workflow_meeting_id,
(select m1.id from meeting_t m1 where m1.motions_default_amendment_workflow_iddd = m.id) as default_amendment_workflow_meeting_id
-- (select array_agg(g.generic_generic_fiel ORDER BY g.generic_generic_fiel) from gm_motion_workflow_generic_generic_field_t g where g.motion_workflow_id = m.id) as generic_generic_field
FROM motion_workflow_t m;

DROP VIEW IF EXISTS "organization_tag";

CREATE VIEW "organization_tag" AS SELECT *
-- (select array_agg(g.org_tagged_id ORDER BY g.org_tagged_id) from gm_organization_tag_org_tagged_ids_t g where g.organization_tag_id = o.id) as org_tagged_ids
FROM organization_tag_t o;


CREATE VIEW "poll" AS SELECT *,
(select array_agg(o.id ORDER BY o.id) from option_t o where o.poll_id = p.id) as option_ids,
(select array_agg(n.user_id ORDER BY n.user_id) from nm_poll_voted_ids_user_t n where n.poll_id = p.id) as voted_ids,
(select array_agg(n.group_id ORDER BY n.group_id) from nm_group_poll_idss_poll_t n where n.poll_id = p.id) as entitled_group_ids,
(select array_agg(pt.id ORDER BY pt.id) from projection_t pt where pt.content_object_id_poll_id = p.id) as projection_ids
FROM poll_t p;

DROP VIEW IF EXISTS "theme";

CREATE VIEW "theme" AS SELECT *,
(select c.id from chaos_t c where c.theme_id = t.id) as theme_for_organization_id
FROM theme_t t;

DROP VIEW IF EXISTS "topic";

CREATE VIEW "topic" AS SELECT *,
(select array_agg(g.meeting_mediafile_id ORDER BY g.meeting_mediafile_id) from gm_meeting_mediafile_attachment_idss_t g where g.attachment_ids_topic_id = t.id) as attachment_meeting_mediafile_ids,
(select a.id from agenda_item_t a where a.content_object_id_topic_id = t.id) as agenda_item_id,
(select l.id from list_of_speakers_t l where l.content_object_id_topic_id = t.id) as list_of_speakers_id,
(select array_agg(p.id ORDER BY p.id) from poll_t p where p.content_object_id_topic_id = t.id) as poll_ids,
(select array_agg(p.id ORDER BY p.id) from projection_t p where p.content_object_id_topic_id = t.id) as projection_ids
FROM topic_t t;

