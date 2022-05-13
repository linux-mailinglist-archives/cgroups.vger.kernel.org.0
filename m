Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651E95268A0
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 19:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383131AbiEMRko (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 13:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383146AbiEMRkl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 13:40:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B91237A0A
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 10:40:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w21-20020a25df15000000b0064b401428bfso6899731ybg.22
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/x54ivsu0L8dQHsfXj5X8iP56Kte1TfUkHVw0Dl1VHM=;
        b=qKV2F/o+1EleqLXGs3rBHm8b6aBfYoNPf/knsl2Sb1SacsaCDUg95ck9Gx6JtESbuB
         bWOP/I/kWCUgv6TttHk+/rePIlVtKrycnPaVy0m0p8e5HUVdlb/N+J+ZYQPgSLRhcVA7
         palQF7MXJL9T433RCaLIjovMH6OYlC1Zf8EWRKAuy6QWAKJmpLrihJkQlgVDTFVvgcpF
         +rvUr1e6PjJHC3AjQBRda2cLpTN8KcZ8+tRav42P62w74xQUOuBPHSRZaacW3Q9GuCim
         STL68JEuK71bfcDTHpyKs+/hjsN3E1JNNCXlgr82AAc1Vi5PV5yIDED0zKWD3VgrW87o
         I+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/x54ivsu0L8dQHsfXj5X8iP56Kte1TfUkHVw0Dl1VHM=;
        b=WYvWhy3lsttV5q+KsVrSobygJYxXBtyJEku5jKKuzvC9YlyIxCTdJ4LLggVjIkaNTw
         tHmtuSYHZLKanxWED7kFxetk6s2lN4DejeBTmIUmZ2Daap8dg5dJfsFeU+BcsAbd8k0F
         Fleh8cJSrJ/ksa6E4aAwlTNI2NlilGRQtCObNXUgn7npCK9m6Z5kaG01LFaTs2V5/FIS
         WZahefugMUzzwildtx3YEqSV7rcpZ8DaD89f8216QhDsKb5mlF5YARVnBQRiDRh2bXRl
         umius/AP/yk2Wd+C9NuXT6kaqAsgbouI6N6/t3eLXiG5b79x7GI2ijnOA8rPxxs4Lfso
         lk+A==
X-Gm-Message-State: AOAM533OGpwp1QAiW0dTCepdbnlgWo7ai+bqZFWB4iErzBO+w8TWchsP
        KSdlfvLc21n+E6IiaaZxlVCAuyT07is=
X-Google-Smtp-Source: ABdhPJxLwlcUI8aiFKGSy1WNiNL6CkqQU8iPRWVD4apx3797fEAEvp/buK2LXv6QRf/g0jHKOaxItcKixA0=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:43f7:a68a:3d8e:73b4])
 (user=khazhy job=sendgmr) by 2002:a81:32c1:0:b0:2f7:cda8:50e1 with SMTP id
 y184-20020a8132c1000000b002f7cda850e1mr7020634ywy.519.1652463633776; Fri, 13
 May 2022 10:40:33 -0700 (PDT)
Date:   Fri, 13 May 2022 10:40:30 -0700
In-Reply-To: <CACGdZYLMW2KHVebfyJZVn9G=15N+Jt4+8oF5gq3wdDTOcXbk9A@mail.gmail.com>
Message-Id: <20220513174030.1307720-1-khazhy@google.com>
Mime-Version: 1.0
References: <CACGdZYLMW2KHVebfyJZVn9G=15N+Jt4+8oF5gq3wdDTOcXbk9A@mail.gmail.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RESEND][RFC PATCH] blkcg: rewind seq_file if no stats
From:   Khazhismel Kumykov <khazhy@google.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Restores the previous behavior of only displaying devices for which we
have statistics (and removes the current, broken, behavior of printing
devname with no newline if no statistics)

In lieu of get_seq_buf + seq_commit, provide a way to "undo" writes if
we use seq_printf

Fixes: 252c651a4c85 ("blk-cgroup: stop using seq_get_buf")

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/blk-cgroup.c       |  5 +++++
 fs/seq_file.c            | 14 ++++++++++++++
 include/linux/seq_file.h |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8dfe62786cd5..50043a742c48 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -909,6 +909,7 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 	const char *dname;
 	unsigned seq;
 	int i;
+	int scookie;
 
 	if (!blkg->online)
 		return;
@@ -917,6 +918,8 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 	if (!dname)
 		return;
 
+	scookie = seq_checkpoint(s);
+
 	seq_printf(s, "%s ", dname);
 
 	do {
@@ -956,6 +959,8 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 
 	if (has_stats)
 		seq_printf(s, "\n");
+	else
+		seq_restore(s, scookie);
 }
 
 static int blkcg_print_stat(struct seq_file *sf, void *v)
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 7ab8a58c29b6..c3ec6b57334e 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -408,6 +408,20 @@ void seq_printf(struct seq_file *m, const char *f, ...)
 }
 EXPORT_SYMBOL(seq_printf);
 
+int seq_checkpoint(struct seq_file *m)
+{
+	return m->count;
+}
+EXPORT_SYMBOL(seq_checkpoint);
+
+void seq_restore(struct seq_file *m, int count)
+{
+	if (WARN_ON_ONCE(count > m->count || count > m->size))
+		return;
+	m->count = count;
+}
+EXPORT_SYMBOL(seq_restore);
+
 #ifdef CONFIG_BINARY_PRINTF
 void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary)
 {
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 60820ab511d2..d3a05f7c2750 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -117,6 +117,8 @@ __printf(2, 0)
 void seq_vprintf(struct seq_file *m, const char *fmt, va_list args);
 __printf(2, 3)
 void seq_printf(struct seq_file *m, const char *fmt, ...);
+int seq_checkpoint(struct seq_file *m);
+void seq_restore(struct seq_file *m, int count);
 void seq_putc(struct seq_file *m, char c);
 void seq_puts(struct seq_file *m, const char *s);
 void seq_put_decimal_ull_width(struct seq_file *m, const char *delimiter,
-- 
2.36.0.550.gb090851708-goog

