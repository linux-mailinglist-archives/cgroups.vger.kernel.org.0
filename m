Return-Path: <cgroups+bounces-17488-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wlfnCZlkSWrG1AAAu9opvQ
	(envelope-from <cgroups+bounces-17488-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:52:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5C708527
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:52:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jvZcJbFh;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17488-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17488-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 044B2302BBAE
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1078130DEA9;
	Sat,  4 Jul 2026 19:52:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7803282F01;
	Sat,  4 Jul 2026 19:52:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194744; cv=none; b=tsZV9yHNUfCrOeVjiQxzg1ojItPROQ3PCGrkEDtnHoGxADmGdkqCKLbh09lJo1ZQXmGSN7eQ1s+0Tmg4q6D/P+XPge3zcm7jrn0sMMOQSlgPlv8buUWahcM28lwinzp3eEcy8/vEvUm0Vw9TIBXBPEL11WGP7zbS19gLl4iU59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194744; c=relaxed/simple;
	bh=SUovTOZikj9roo0SdyF8GfzPjY4QpQlHgzisLh6yaY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqkC2NjUAPGULbuhtJmU6sJDDVEMJH5SpfkZKjjHNguYqKy76bBfOPMe4mTT5Y2Wy3Wvn84fHjE8VEIE3sKWXjdEZFIWX61voO3lPI8bnUPx7x7V2n5cjsI6hOdUOQrTj6LAt8MSW6U9e13OMK8v8iJcAjlsfJ+PyqGVbrHV6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvZcJbFh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66E81F000E9;
	Sat,  4 Jul 2026 19:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194743;
	bh=3ufHR6WcCfu/uFKPa4VS21/xvyGG7qfM6HO7NiBTt5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jvZcJbFh/Cx+r6qJ3jGtjFZVEDHkPTJ44v98iKdAgLyASaibfSfY7sGH1vWHPajZs
	 PllkZQRybKGEbqmwmvePobLfnPjOMhPRSB4PyG+ku2UzNApK1WUUldpNqHJi0qfCch
	 lqjNm870SdBrUjwKQ17SQJunUouBaKYQniC48Mz10Pdgbi/Ffz4OE61zSWSWFlHhBj
	 TyifFbQbYweXgIsoHmPISAI3pVFK0HOrz2ohKWbox53e0RZI4lyqYECpDk3KDr6IHq
	 xcU6+6cICME4GiNB51Uc5c+U01iWVR6tnz7OkNUUAteSl0P/9/N1R0arjfcejr0+o1
	 hvIOGoRwpEDLQ==
From: Yu Kuai <yukuai@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev,
	linux-bcache@vger.kernel.org
Subject: [RFC PATCH v1 03/17] dm snapshot: avoid bio_set_dev in locked map paths
Date: Sun,  5 Jul 2026 03:51:10 +0800
Message-ID: <20260704195124.1375075-4-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260704195124.1375075-1-yukuai@kernel.org>
References: <20260704195124.1375075-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17488-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:hch@lst.de,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:yukuai@fygo.io,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1F5C708527

From: Yu Kuai <yukuai@fygo.io>

bio_set_dev() is about to become explicitly sleepable.  It currently
updates the bio's target device and then associates the bio with the
destination queue's blkcg state.  After blkcg lookup/creation is moved
under the queue's blkcg_mutex, that association may take blkcg_mutex and
allocate a new blkg.  Callers therefore must not invoke bio_set_dev() from
atomic or otherwise non-sleepable sections.

snapshot_map() has several remap decisions inside
dm_exception_table_lock(), which nests the completed and pending
exception hash-table spinlocks.  Those locks protect the lookup result,
pending-exception insertion, pe->started, and the pending bio lists until
the bio has either been returned to DM core or queued on the pending
exception.  Dropping the locks just to call bio_set_dev() would require
revalidating the exception state and preserving the pending-list ordering
rules; calling a sleepable bio_set_dev() while holding the spinlocks is not
allowed either.

Split out snapshot_bio_set_dev() for these locked remap decisions.  It only
performs the non-sleeping part of bio_set_dev(): clear BIO_REMAPPED, clear
BIO_BPS_THROTTLED when the bdev changes, and update bi_bdev.  It
deliberately does not associate the bio with a blkg while snapshot locks
are held.

This does not lose blkcg attribution for the normal DM_MAPIO_REMAPPED case.
After the target returns, DM core submits the mapped bio through
dm_submit_bio_remap(), and that helper clones the blkg association from the
original bio in the normal submission context.

Some snapshot bios are not submitted by DM core immediately.  Writes
waiting for a pending exception and bios queued during snapshot merge are
kept on snapshot-owned lists and submitted later after copy or merge
completion.  Once bio_set_dev() is no longer used in the locked path,
these delayed bios also need their blkcg association restored at submission
time.  Submit those bios through dm_submit_bio_remap() instead of
submit_bio_noacct() so the association is cloned from the original bio
after the snapshot locks have been released.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/md/dm-snap.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 1489fda9d24a..373a94156ec7 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -192,6 +192,19 @@ static sector_t chunk_to_sector(struct dm_exception_store *store,
 	return chunk << store->chunk_shift;
 }
 
+/*
+ * Snapshot exception-table locks are spinlocks.  Only update the target
+ * device while holding them; dm_submit_bio_remap() will associate target-owned
+ * bios with the original bio's blkg from a sleepable submission context.
+ */
+static void snapshot_bio_set_dev(struct bio *bio, struct block_device *bdev)
+{
+	bio_clear_flag(bio, BIO_REMAPPED);
+	if (bio->bi_bdev != bdev)
+		bio_clear_flag(bio, BIO_BPS_THROTTLED);
+	bio->bi_bdev = bdev;
+}
+
 static int bdev_equal(struct block_device *lhs, struct block_device *rhs)
 {
 	/*
@@ -1566,7 +1579,7 @@ static void flush_bios(struct bio *bio)
 	while (bio) {
 		n = bio->bi_next;
 		bio->bi_next = NULL;
-		submit_bio_noacct(bio);
+		dm_submit_bio_remap(bio, NULL);
 		bio = n;
 	}
 }
@@ -1586,7 +1599,7 @@ static void retry_origin_bios(struct dm_snapshot *s, struct bio *bio)
 		bio->bi_next = NULL;
 		r = do_origin(s->origin, bio, false);
 		if (r == DM_MAPIO_REMAPPED)
-			submit_bio_noacct(bio);
+			dm_submit_bio_remap(bio, NULL);
 		bio = n;
 	}
 }
@@ -1827,7 +1840,7 @@ static void start_full_bio(struct dm_snap_pending_exception *pe,
 	bio->bi_end_io = full_bio_end_io;
 	bio->bi_private = callback_data;
 
-	submit_bio_noacct(bio);
+	dm_submit_bio_remap(bio, NULL);
 }
 
 static struct dm_snap_pending_exception *
@@ -1898,7 +1911,7 @@ __find_pending_exception(struct dm_snapshot *s,
 static void remap_exception(struct dm_snapshot *s, struct dm_exception *e,
 			    struct bio *bio, chunk_t chunk)
 {
-	bio_set_dev(bio, s->cow->bdev);
+	snapshot_bio_set_dev(bio, s->cow->bdev);
 	bio->bi_iter.bi_sector =
 		chunk_to_sector(s->store, dm_chunk_number(e->new_chunk) +
 				(chunk - e->old_chunk)) +
@@ -1982,7 +1995,7 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 			 * defeat the goal of freeing space in origin that is
 			 * implied by the "discard_passdown_origin" feature)
 			 */
-			bio_set_dev(bio, s->origin->bdev);
+			snapshot_bio_set_dev(bio, s->origin->bdev);
 			track_chunk(s, bio, chunk);
 			goto out_unlock;
 		}
@@ -2081,7 +2094,7 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 			goto out;
 		}
 	} else {
-		bio_set_dev(bio, s->origin->bdev);
+		snapshot_bio_set_dev(bio, s->origin->bdev);
 		track_chunk(s, bio, chunk);
 	}
 
@@ -2143,7 +2156,7 @@ static int snapshot_merge_map(struct dm_target *ti, struct bio *bio)
 		    chunk >= s->first_merging_chunk &&
 		    chunk < (s->first_merging_chunk +
 			     s->num_merging_chunks)) {
-			bio_set_dev(bio, s->origin->bdev);
+			snapshot_bio_set_dev(bio, s->origin->bdev);
 			bio_list_add(&s->bios_queued_during_merge, bio);
 			r = DM_MAPIO_SUBMITTED;
 			goto out_unlock;
@@ -2157,7 +2170,7 @@ static int snapshot_merge_map(struct dm_target *ti, struct bio *bio)
 	}
 
 redirect_to_origin:
-	bio_set_dev(bio, s->origin->bdev);
+	snapshot_bio_set_dev(bio, s->origin->bdev);
 
 	if (bio_data_dir(bio) == WRITE) {
 		up_write(&s->lock);
-- 
2.51.0


