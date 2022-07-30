Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBBF58583F
	for <lists+cgroups@lfdr.de>; Sat, 30 Jul 2022 05:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbiG3DZQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 23:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbiG3DZM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 23:25:12 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB35BB4
        for <cgroups@vger.kernel.org>; Fri, 29 Jul 2022 20:25:09 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id y8-20020a056602200800b0067c008bfdfeso1858724iod.2
        for <cgroups@vger.kernel.org>; Fri, 29 Jul 2022 20:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Le6CaLI6B5guGWuq3Gyd/hvNCiyTuMEnCMic+ruQwAg=;
        b=dpoj0aG52Mf0kHVzhCaPA1AzPIxP5itDXuBKDJ1oQi9hcW4xOO/eZcHnlum7k/ti0s
         9WeYmSuBR/plreh36YVEkOjCeAbYpKW9i2GX9+YJzv6uGy2i/L7lgOpmmUWUhhKVNkTF
         s4A6PFH45QqiFnpHqOZWz6KLZ0bE69WpYq6uAt5jJxAouGPe4ZZ+9TJoRwO4UmSX/ld1
         OZkq0UA6XiySlgXp9xxax5fDohtOx0fP6sBPvgH7BWgEsbYKrORgZzYcYUr+KvFr4iRp
         tpVzca5mr76x8tdmKx+po48XGpk8oUDNZ4MzL/1NQeK0kiTlgkZJFpjFGQu6afn52ynI
         JmRw==
X-Gm-Message-State: AJIora+cL0GzrfKAXiTizgLhFPiDhNTbFdfKwbJkMPldgtuYez83BXZh
        TKhkD4g3dFUSV1KmePHGbT9VDtvEIgb2P+R5PrF9XEk6/nK1
X-Google-Smtp-Source: AGRyM1uZmbuimnvUNNN7eYgZxebUEc8abU1NLOXrLNTLjgqi426QKsMvgCMdvZuw8bnYIkGGZLa27J5FmS+eqomTrhDSEVcJwthc
MIME-Version: 1.0
X-Received: by 2002:a92:c884:0:b0:2dc:bd44:84bf with SMTP id
 w4-20020a92c884000000b002dcbd4484bfmr2389723ilo.86.1659151508737; Fri, 29 Jul
 2022 20:25:08 -0700 (PDT)
Date:   Fri, 29 Jul 2022 20:25:08 -0700
In-Reply-To: <000000000000921fd405db62096a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e96a405e4fd5051@google.com>
Subject: Re: [syzbot] possible deadlock in throtl_pending_timer_fn
From:   syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org, hdanton@sina.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

syzbot has bisected this issue to:

commit 0a9a25ca78437b39e691bcc3dc8240455b803d8d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Mar 18 13:01:43 2022 +0000

    block: let blkcg_gq grab request queue's refcnt

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c3cfc2080000
start commit:   cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15c3cfc2080000
console output: https://syzkaller.appspot.com/x/log.txt?x=11c3cfc2080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17713dee080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d24952080000

Reported-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com
Fixes: 0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
