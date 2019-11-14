Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B84FCBB5
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2019 18:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKNRUr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Nov 2019 12:20:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44983 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKNRUq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Nov 2019 12:20:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id m16so5632037qki.11
        for <cgroups@vger.kernel.org>; Thu, 14 Nov 2019 09:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YqwdU+TFDkkxeSf2VYe9ZpBpe5HohVUl6w94HLyvpv4=;
        b=DlliewnnkIDrzyiGW6RRf47VJWcYu9agI8oocX5cMZTL9y15bhlZQRDMvE5MT78YdP
         zcMXIkm2lf2uixuxxrR7TpZBOro6CWVqnGOFPkIji7YlCEvYmh7Gj2c6JvYQpWiBaOue
         uvQG5LKFugb1tu+AKQCPa5OwXYgkuGmb3yRWQ5MiN/cf72DHj0Lg9BtTfkwRH/UsulX8
         RRv5fiZMCZpRzFhuZGsmHhX948nUNvK3m2ISbHvJ+m0mOVr1QEZQfT3mv86iPS2bRoek
         vaeu1KA6aJ+gEuBJOxMpQTPEMQFxH/4CL5yU261QQNp5J127yMMx0GrbtLb3ZuBJCerO
         pUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YqwdU+TFDkkxeSf2VYe9ZpBpe5HohVUl6w94HLyvpv4=;
        b=uX+/WReX2l7jewfOtaT+C8nWHcnWXAhXv0j09JZpq5XVabxU+JbVyhhaYVpvXkKdCX
         InVmQdBKP51eOdIc3icmNpNpC/v8Nd8AXEs3m7LDc8g8/GW/TruJpck6w4Z30Flz6PN6
         t/+s4WWBt0DW3R/vpbWqsXoQ7twAcB0WV8p8FboNhm+shv53bHMbYi2eT+hH48V+HF6w
         Eun/aYoB4x+22fkhiJLWf92djPYT5UUyQMDoj0yCNN17tUGry7XOIPUlhoZcOKligPAR
         vY0hr6w8RiC7jVFdhWUZUQ9eFV7lnK7lc2dL8mCawL+9bB/pP++wrq2zTGRENmK8h/ID
         GdlQ==
X-Gm-Message-State: APjAAAUfVTLnnNmSrmnwZklS/w9/SvSyl/44yu+oOYCu1V83xS1TTarA
        pxvYHKahKmOpPG1ksMb0g4ycBjgIymw=
X-Google-Smtp-Source: APXvYqydvgsfrEZ+98C5vPABHk4+serIieb4Y3cV7B/XOTnjWmTMEvr7ItsMVDyi+jqFkW92BOmm8Q==
X-Received: by 2002:a05:620a:999:: with SMTP id x25mr4654431qkx.189.1573752044966;
        Thu, 14 Nov 2019 09:20:44 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p59sm3455986qtd.2.2019.11.14.09.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 09:20:44 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tj@kernel.org
Cc:     jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] writeback: fix -Wformat compilation warnings
Date:   Thu, 14 Nov 2019 12:17:41 -0500
Message-Id: <1573751861-10303-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The commit f05499a06fb4 ("writeback: use ino_t for inodes in
tracepoints") introduced a lot of GCC compilation warnings on s390,

In file included from ./include/trace/define_trace.h:102,
                 from ./include/trace/events/writeback.h:904,
                 from fs/fs-writeback.c:82:
./include/trace/events/writeback.h: In function
'trace_raw_output_writeback_page_template':
./include/trace/events/writeback.h:76:12: warning: format '%lu' expects
argument of type 'long unsigned int', but argument 4 has type 'ino_t'
{aka 'unsigned int'} [-Wformat=]
  TP_printk("bdi %s: ino=%lu index=%lu",
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/trace/trace_events.h:360:22: note: in definition of macro
'DECLARE_EVENT_CLASS'
  trace_seq_printf(s, print);     \
                      ^~~~~
./include/trace/events/writeback.h:76:2: note: in expansion of macro
'TP_printk'
  TP_printk("bdi %s: ino=%lu index=%lu",
  ^~~~~~~~~

Fix them by adding necessary casts where ino_t could be either "unsigned
int" or "unsigned long".

Fixes: f05499a06fb4 ("writeback: use ino_t for inodes in tracepoints")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/trace/events/writeback.h | 48 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index b4f0ffe1817e..ef50be4e5e6c 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -75,7 +75,7 @@
 
 	TP_printk("bdi %s: ino=%lu index=%lu",
 		__entry->name,
-		__entry->ino,
+		(unsigned long)__entry->ino,
 		__entry->index
 	)
 );
@@ -120,7 +120,7 @@
 
 	TP_printk("bdi %s: ino=%lu state=%s flags=%s",
 		__entry->name,
-		__entry->ino,
+		(unsigned long)__entry->ino,
 		show_inode_state(__entry->state),
 		show_inode_state(__entry->flags)
 	)
@@ -201,8 +201,8 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 
 	TP_printk("bdi %s: ino=%lu cgroup_ino=%lu history=0x%x",
 		__entry->name,
-		__entry->ino,
-		__entry->cgroup_ino,
+		(unsigned long)__entry->ino,
+		(unsigned long)__entry->cgroup_ino,
 		__entry->history
 	)
 );
@@ -230,9 +230,9 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 
 	TP_printk("bdi %s: ino=%lu old_cgroup_ino=%lu new_cgroup_ino=%lu",
 		__entry->name,
-		__entry->ino,
-		__entry->old_cgroup_ino,
-		__entry->new_cgroup_ino
+		(unsigned long)__entry->ino,
+		(unsigned long)__entry->old_cgroup_ino,
+		(unsigned long)__entry->new_cgroup_ino
 	)
 );
 
@@ -266,10 +266,10 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%lu page_cgroup_ino=%lu",
 		__entry->name,
 		__entry->bdi_id,
-		__entry->ino,
+		(unsigned long)__entry->ino,
 		__entry->memcg_id,
-		__entry->cgroup_ino,
-		__entry->page_cgroup_ino
+		(unsigned long)__entry->cgroup_ino,
+		(unsigned long)__entry->page_cgroup_ino
 	)
 );
 
@@ -296,7 +296,7 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 
 	TP_printk("bdi %s: cgroup_ino=%lu frn_bdi_id=%u frn_memcg_id=%u",
 		__entry->name,
-		__entry->cgroup_ino,
+		(unsigned long)__entry->cgroup_ino,
 		__entry->frn_bdi_id,
 		__entry->frn_memcg_id
 	)
@@ -326,9 +326,9 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 
 	TP_printk("bdi %s: ino=%lu sync_mode=%d cgroup_ino=%lu",
 		__entry->name,
-		__entry->ino,
+		(unsigned long)__entry->ino,
 		__entry->sync_mode,
-		__entry->cgroup_ino
+		(unsigned long)__entry->cgroup_ino
 	)
 );
 
@@ -383,7 +383,7 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 		  __entry->range_cyclic,
 		  __entry->for_background,
 		  __print_symbolic(__entry->reason, WB_WORK_REASON),
-		  __entry->cgroup_ino
+		  (unsigned long)__entry->cgroup_ino
 	)
 );
 #define DEFINE_WRITEBACK_WORK_EVENT(name) \
@@ -421,7 +421,7 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 	),
 	TP_printk("bdi %s: cgroup_ino=%lu",
 		  __entry->name,
-		  __entry->cgroup_ino
+		  (unsigned long)__entry->cgroup_ino
 	)
 );
 #define DEFINE_WRITEBACK_EVENT(name) \
@@ -489,7 +489,7 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 		__entry->range_cyclic,
 		__entry->range_start,
 		__entry->range_end,
-		__entry->cgroup_ino
+		(unsigned long)__entry->cgroup_ino
 	)
 )
 
@@ -528,7 +528,7 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 		__entry->age,	/* older_than_this in relative milliseconds */
 		__entry->moved,
 		__print_symbolic(__entry->reason, WB_WORK_REASON),
-		__entry->cgroup_ino
+		(unsigned long)__entry->cgroup_ino
 	)
 );
 
@@ -622,7 +622,7 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 		  __entry->dirty_ratelimit,	/* base ratelimit */
 		  __entry->task_ratelimit, /* ratelimit with position control */
 		  __entry->balanced_dirty_ratelimit, /* the balanced ratelimit */
-		  __entry->cgroup_ino
+		  (unsigned long)__entry->cgroup_ino
 	)
 );
 
@@ -707,7 +707,7 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 		  __entry->pause,	/* ms */
 		  __entry->period,	/* ms */
 		  __entry->think,	/* ms */
-		  __entry->cgroup_ino
+		  (unsigned long)__entry->cgroup_ino
 	  )
 );
 
@@ -735,11 +735,11 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 
 	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu cgroup_ino=%lu",
 		  __entry->name,
-		  __entry->ino,
+		  (unsigned long)__entry->ino,
 		  show_inode_state(__entry->state),
 		  __entry->dirtied_when,
 		  (jiffies - __entry->dirtied_when) / HZ,
-		  __entry->cgroup_ino
+		  (unsigned long)__entry->cgroup_ino
 	)
 );
 
@@ -813,14 +813,14 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu "
 		  "index=%lu to_write=%ld wrote=%lu cgroup_ino=%lu",
 		  __entry->name,
-		  __entry->ino,
+		  (unsigned long)__entry->ino,
 		  show_inode_state(__entry->state),
 		  __entry->dirtied_when,
 		  (jiffies - __entry->dirtied_when) / HZ,
 		  __entry->writeback_index,
 		  __entry->nr_to_write,
 		  __entry->wrote,
-		  __entry->cgroup_ino
+		  (unsigned long)__entry->cgroup_ino
 	)
 );
 
@@ -861,7 +861,7 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 
 	TP_printk("dev %d,%d ino %lu dirtied %lu state %s mode 0%o",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  __entry->ino, __entry->dirtied_when,
+		  (unsigned long)__entry->ino, __entry->dirtied_when,
 		  show_inode_state(__entry->state), __entry->mode)
 );
 
-- 
1.8.3.1

