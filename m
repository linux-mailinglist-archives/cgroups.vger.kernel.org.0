Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D579F70AFEC
	for <lists+cgroups@lfdr.de>; Sun, 21 May 2023 21:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEUTaX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 21 May 2023 15:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUTaX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 21 May 2023 15:30:23 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDABDE
        for <cgroups@vger.kernel.org>; Sun, 21 May 2023 12:30:18 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2536e2c336dso1724274a91.2
        for <cgroups@vger.kernel.org>; Sun, 21 May 2023 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684697418; x=1687289418;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QsimBcbFkkOqpywwSH5EJmOyk1K46aweYARqzOVnpbQ=;
        b=AwAik3WBbsct7NHTK6mPHFMdHYq0nx82//vVz1V6opRw5i8IPg0Ue9Coqr0iV4/bk+
         SD6HHE9uIf5r3eg6/MKyA7eUk8I3MrANEz+hkV7gQhVeURby/SVKQW7nV6gOc+y9lHLJ
         RscGr1/QqfmQMCRw7KydEfjk4FTpyhkfgP/XVgY0tXk+VgTH4yy7+98lBP5r3iFKoCty
         YOtb/qJ71FZIuoLQEP6DhJRGVOiVLDob2y2gMupeXKSi0qwe3K1IW/NHW9plCPo/jRfI
         4J5Qyf6tlrDYkWoIKf+67HIDR+H14iGWbAx4tRshmD8zE50IlDQDS3OttxBrWj3+YGQL
         V50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684697418; x=1687289418;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsimBcbFkkOqpywwSH5EJmOyk1K46aweYARqzOVnpbQ=;
        b=Ad5umKmjzcI7pypnkZro975SuaRH+psVO+/EizogmFaCdtx1gHd5VPXNXI6QeY+juU
         20lDwbPh/xyT5yxUcgFjS/FqUiGlV5zmoYt4/00xkEJUo+AGM/UBV44vEWaHns6UpVsJ
         L+r5R8w6KVZgh9inM0oQwC+olEUFHSg0XDWuozvlGZjyHLCu0jxm00PlUiJR+JnJvbQu
         U3vWDNRdwqR4LqMxgPfSqs21yJ/q427o83ygWyr0QnspcaKa9Bh/JknCaIj2IqS7QjDA
         8NKN+6ETQles2IZ2qRobCKdrXvuEnzSbf0RkG1kEOGRGc+rxZnsVFgDlHanIouT6uAdJ
         ZqVg==
X-Gm-Message-State: AC+VfDwr/gA7xDDkedEIB1LpluRY3MTzKsS7GRf1Fs1f7RsbxuzFCE8V
        kl32DLjFlNlRXtErL8XAAAFufeCipPu+pYk=
X-Google-Smtp-Source: ACHHUZ4q24M1hgL/PDu3hElXQsY6isH5Lvfu+OTm9AgPvDWrMpxBNVXD0irehC0CKk3UkmJchSSOx/dBbJlAa2o=
X-Received: from jsperbeck8.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:301f])
 (user=jsperbeck job=sendgmr) by 2002:a17:90a:b292:b0:255:4b79:1efe with SMTP
 id c18-20020a17090ab29200b002554b791efemr728122pjr.7.1684697418404; Sun, 21
 May 2023 12:30:18 -0700 (PDT)
Date:   Sun, 21 May 2023 19:29:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230521192953.229715-1-jsperbeck@google.com>
Subject: [PATCH] cgroup: always put cset in cgroup_css_set_put_fork
From:   John Sperbeck <jsperbeck@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A successful call to cgroup_css_set_fork() will always have taken
a ref on kargs->cset (regardless of CLONE_INTO_CGROUP), so always
do a corresponding put in cgroup_css_set_put_fork().

Without this, a cset and its contained css structures will be
leaked for some fork failures.  The following script reproduces
the leak for a fork failure due to exceeding pids.max in the
pids controller.  A similar thing can happen if we jump to the
bad_fork_cancel_cgroup label in copy_process().

[ -z "$1" ] && echo "Usage $0 pids-root" && exit 1
PID_ROOT=$1
CGROUP=$PID_ROOT/foo

[ -e $CGROUP ] && rmdir -f $CGROUP
mkdir $CGROUP
echo 5 > $CGROUP/pids.max
echo $$ > $CGROUP/cgroup.procs

fork_bomb()
{
	set -e
	for i in $(seq 10); do
		/bin/sleep 3600 &
	done
}

(fork_bomb) &
wait
echo $$ > $PID_ROOT/cgroup.procs
kill $(cat $CGROUP/cgroup.procs)
rmdir $CGROUP

Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 kernel/cgroup/cgroup.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 625d7483951c..245cf62ce85a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6486,19 +6486,18 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
 	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
 {
+	struct cgroup *cgrp = kargs->cgrp;
+	struct css_set *cset = kargs->cset;
+
 	cgroup_threadgroup_change_end(current);
 
-	if (kargs->flags & CLONE_INTO_CGROUP) {
-		struct cgroup *cgrp = kargs->cgrp;
-		struct css_set *cset = kargs->cset;
+	if (cset) {
+		put_css_set(cset);
+		kargs->cset = NULL;
+	}
 
+	if (kargs->flags & CLONE_INTO_CGROUP) {
 		cgroup_unlock();
-
-		if (cset) {
-			put_css_set(cset);
-			kargs->cset = NULL;
-		}
-
 		if (cgrp) {
 			cgroup_put(cgrp);
 			kargs->cgrp = NULL;
-- 
2.40.1.698.g37aff9b760-goog

