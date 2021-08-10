Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D853E7C26
	for <lists+cgroups@lfdr.de>; Tue, 10 Aug 2021 17:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243053AbhHJP2Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Aug 2021 11:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbhHJP2P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Aug 2021 11:28:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760DC0613C1;
        Tue, 10 Aug 2021 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=x+IC4nJXNjYXSgrpS0H9Iw4lxiCXLC6AqMo7bC8Od6w=; b=K59U+v+vekpIID2gPUGSsTvnRW
        mMo79IJr6MybkVLcxZPl7NRcbWgF6E2Bmzsz69gpnjCjg4wagQh0jm4sdswjW5T6wegR7BB5zmedE
        eTrw19OOMnqLvQthf82Y0UlSekWHwwCcGnPsw57qmvPC4L6BXJm+QLetupGlzIE12t+qm8fnp4hSk
        VdTDJuhcCTvMxON+0AsUIkL/7vIV3NDIpdao7h3HBTUP+exg92VP5GrQvXT5uKiV0EjhPPXGnXcrh
        LLYQfj8+z55yIEr3UM8S8/0GIC09DpiXAL6/ljvOxKFKz9To/E35kIVbBIoViRClitnsM9e0TeGli
        US2MbI8w==;
Received: from 089144200071.atnat0009.highway.a1.net ([89.144.200.71] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDTe4-00CHXf-Ix; Tue, 10 Aug 2021 15:26:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     tj@kernel.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 1/2] blk-cgroup: refactor blkcg_print_stat
Date:   Tue, 10 Aug 2021 17:26:22 +0200
Message-Id: <20210810152623.1796144-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Factor out a helper to deal with a single blkcg_gq to make the code a
little bit easier to follow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 148 ++++++++++++++++++++++-----------------------
 1 file changed, 74 insertions(+), 74 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index db034e35ae20..52aa0540ccaf 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -870,97 +870,97 @@ static void blkcg_fill_root_iostats(void)
 	}
 }
 
-static int blkcg_print_stat(struct seq_file *sf, void *v)
+static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 {
-	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
-	struct blkcg_gq *blkg;
-
-	if (!seq_css(sf)->parent)
-		blkcg_fill_root_iostats();
-	else
-		cgroup_rstat_flush(blkcg->css.cgroup);
-
-	rcu_read_lock();
+	struct blkg_iostat_set *bis = &blkg->iostat;
+	u64 rbytes, wbytes, rios, wios, dbytes, dios;
+	bool has_stats = false;
+	const char *dname;
+	unsigned seq;
+	char *buf;
+	size_t size = seq_get_buf(s, &buf), off = 0;
+	int i;
 
-	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
-		struct blkg_iostat_set *bis = &blkg->iostat;
-		const char *dname;
-		char *buf;
-		u64 rbytes, wbytes, rios, wios, dbytes, dios;
-		size_t size = seq_get_buf(sf, &buf), off = 0;
-		int i;
-		bool has_stats = false;
-		unsigned seq;
+	if (!blkg->online)
+		return;
 
-		spin_lock_irq(&blkg->q->queue_lock);
+	dname = blkg_dev_name(blkg);
+	if (!dname)
+		return;
 
-		if (!blkg->online)
-			goto skip;
+	/*
+	 * Hooray string manipulation, count is the size written NOT
+	 * INCLUDING THE \0, so size is now count+1 less than what we
+	 * had before, but we want to start writing the next bit from
+	 * the \0 so we only add count to buf.
+	 */
+	off += scnprintf(buf+off, size-off, "%s ", dname);
 
-		dname = blkg_dev_name(blkg);
-		if (!dname)
-			goto skip;
+	do {
+		seq = u64_stats_fetch_begin(&bis->sync);
+
+		rbytes = bis->cur.bytes[BLKG_IOSTAT_READ];
+		wbytes = bis->cur.bytes[BLKG_IOSTAT_WRITE];
+		dbytes = bis->cur.bytes[BLKG_IOSTAT_DISCARD];
+		rios = bis->cur.ios[BLKG_IOSTAT_READ];
+		wios = bis->cur.ios[BLKG_IOSTAT_WRITE];
+		dios = bis->cur.ios[BLKG_IOSTAT_DISCARD];
+	} while (u64_stats_fetch_retry(&bis->sync, seq));
+
+	if (rbytes || wbytes || rios || wios) {
+		has_stats = true;
+		off += scnprintf(buf+off, size-off,
+			"rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",
+			rbytes, wbytes, rios, wios,
+			dbytes, dios);
+	}
 
-		/*
-		 * Hooray string manipulation, count is the size written NOT
-		 * INCLUDING THE \0, so size is now count+1 less than what we
-		 * had before, but we want to start writing the next bit from
-		 * the \0 so we only add count to buf.
-		 */
-		off += scnprintf(buf+off, size-off, "%s ", dname);
+	if (blkcg_debug_stats && atomic_read(&blkg->use_delay)) {
+		has_stats = true;
+		off += scnprintf(buf+off, size-off, " use_delay=%d delay_nsec=%llu",
+			atomic_read(&blkg->use_delay),
+			atomic64_read(&blkg->delay_nsec));
+	}
 
-		do {
-			seq = u64_stats_fetch_begin(&bis->sync);
+	for (i = 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol = blkcg_policy[i];
+		size_t written;
 
-			rbytes = bis->cur.bytes[BLKG_IOSTAT_READ];
-			wbytes = bis->cur.bytes[BLKG_IOSTAT_WRITE];
-			dbytes = bis->cur.bytes[BLKG_IOSTAT_DISCARD];
-			rios = bis->cur.ios[BLKG_IOSTAT_READ];
-			wios = bis->cur.ios[BLKG_IOSTAT_WRITE];
-			dios = bis->cur.ios[BLKG_IOSTAT_DISCARD];
-		} while (u64_stats_fetch_retry(&bis->sync, seq));
+		if (!blkg->pd[i] || !pol->pd_stat_fn)
+			continue;
 
-		if (rbytes || wbytes || rios || wios) {
+		written = pol->pd_stat_fn(blkg->pd[i], buf+off, size-off);
+		if (written)
 			has_stats = true;
-			off += scnprintf(buf+off, size-off,
-					 "rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",
-					 rbytes, wbytes, rios, wios,
-					 dbytes, dios);
-		}
+		off += written;
+	}
 
-		if (blkcg_debug_stats && atomic_read(&blkg->use_delay)) {
-			has_stats = true;
-			off += scnprintf(buf+off, size-off,
-					 " use_delay=%d delay_nsec=%llu",
-					 atomic_read(&blkg->use_delay),
-					(unsigned long long)atomic64_read(&blkg->delay_nsec));
+	if (has_stats) {
+		if (off < size - 1) {
+			off += scnprintf(buf+off, size-off, "\n");
+			seq_commit(s, off);
+		} else {
+			seq_commit(s, -1);
 		}
+	}
+}
 
-		for (i = 0; i < BLKCG_MAX_POLS; i++) {
-			struct blkcg_policy *pol = blkcg_policy[i];
-			size_t written;
-
-			if (!blkg->pd[i] || !pol->pd_stat_fn)
-				continue;
+static int blkcg_print_stat(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+	struct blkcg_gq *blkg;
 
-			written = pol->pd_stat_fn(blkg->pd[i], buf+off, size-off);
-			if (written)
-				has_stats = true;
-			off += written;
-		}
+	if (!seq_css(sf)->parent)
+		blkcg_fill_root_iostats();
+	else
+		cgroup_rstat_flush(blkcg->css.cgroup);
 
-		if (has_stats) {
-			if (off < size - 1) {
-				off += scnprintf(buf+off, size-off, "\n");
-				seq_commit(sf, off);
-			} else {
-				seq_commit(sf, -1);
-			}
-		}
-	skip:
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+		spin_lock_irq(&blkg->q->queue_lock);
+		blkcg_print_one_stat(blkg, sf);
 		spin_unlock_irq(&blkg->q->queue_lock);
 	}
-
 	rcu_read_unlock();
 	return 0;
 }
-- 
2.30.2

