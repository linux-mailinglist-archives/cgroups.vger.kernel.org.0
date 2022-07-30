Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0155585A37
	for <lists+cgroups@lfdr.de>; Sat, 30 Jul 2022 13:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiG3LR4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 30 Jul 2022 07:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiG3LRz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 30 Jul 2022 07:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F7F01EC74
        for <cgroups@vger.kernel.org>; Sat, 30 Jul 2022 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659179873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ajeH2EPldj0oFW5NJlh68z51lwf7zGjC5FfPekouKAo=;
        b=K/oqLsJR9vzL6Ns280aqnin31IffffEJsIMPO7a7pO05QDFXGlQUb0a1rm2h9zm7CQg1sD
        D65wEq9YJfj0/SR9s25f72Yicaricr34cb8tE158EX6u7QFOQ9yxQ7dzqA/NCGUy5n04oF
        S/ga0FS4peZqNgFl/u4kwiRoZ9wrxns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-Ok_HGvXdP6SII63yWAl8ww-1; Sat, 30 Jul 2022 07:17:50 -0400
X-MC-Unique: Ok_HGvXdP6SII63yWAl8ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C008101A54E;
        Sat, 30 Jul 2022 11:17:49 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAC6A2026D07;
        Sat, 30 Jul 2022 11:17:43 +0000 (UTC)
Date:   Sat, 30 Jul 2022 19:17:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org, hdanton@sina.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        Yufen Yu <yuyufen@huawei.com>
Subject: Re: [syzbot] possible deadlock in throtl_pending_timer_fn
Message-ID: <YuUTUkxYFTKr6Ih3@T590>
References: <000000000000921fd405db62096a@google.com>
 <0000000000004e96a405e4fd5051@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004e96a405e4fd5051@google.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 29, 2022 at 08:25:08PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 0a9a25ca78437b39e691bcc3dc8240455b803d8d
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Mar 18 13:01:43 2022 +0000
> 
>     block: let blkcg_gq grab request queue's refcnt
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c3cfc2080000
> start commit:   cb71b93c2dc3 Add linux-next specific files for 20220628
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15c3cfc2080000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11c3cfc2080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
> dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17713dee080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d24952080000
> 
> Reported-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com
> Fixes: 0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt")

No, this lockdep warning isn't related with the above commit, which
caused another regression, but fixed by commit d578c770c852
("block: avoid calling blkg_free() in atomic context"). Looks syzbot
can't recognize difference between the two different issues.

This specific issue of '[syzbot] possible deadlock in throtl_pending_timer_fn',
is actually introduced by commit ("27029b4b18aa blkcg: fix memleak for iolatency").

blk_throtl_exit() isn't safe to be called before blkg_destroy_all().

The following change should avoid the issue:


diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 869af9d72bcf..1606acb917fd 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1268,6 +1268,7 @@ static int blkcg_css_online(struct cgroup_subsys_state *css)
 int blkcg_init_queue(struct request_queue *q)
 {
 	struct blkcg_gq *new_blkg, *blkg;
+	bool need_exit_throtl = false;
 	bool preloaded;
 	int ret;
 
@@ -1301,7 +1302,7 @@ int blkcg_init_queue(struct request_queue *q)
 
 	ret = blk_iolatency_init(q);
 	if (ret) {
-		blk_throtl_exit(q);
+		need_exit_throtl = true;
 		blk_ioprio_exit(q);
 		goto err_destroy_all;
 	}
@@ -1310,6 +1311,8 @@ int blkcg_init_queue(struct request_queue *q)
 
 err_destroy_all:
 	blkg_destroy_all(q);
+	if (need_exit_throtl)
+		blk_throtl_exit(q);
 	return ret;
 err_unlock:
 	spin_unlock_irq(&q->queue_lock);



Thanks,
Ming

