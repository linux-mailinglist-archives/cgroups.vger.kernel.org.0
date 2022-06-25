Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0092455A76E
	for <lists+cgroups@lfdr.de>; Sat, 25 Jun 2022 08:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiFYGAN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Jun 2022 02:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiFYGAN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Jun 2022 02:00:13 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299D022520
        for <cgroups@vger.kernel.org>; Fri, 24 Jun 2022 23:00:10 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s6-20020a056e021a0600b002d8fcba296aso2874202ild.20
        for <cgroups@vger.kernel.org>; Fri, 24 Jun 2022 23:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IKMceRPaWc2G+dnHVKLDkc7HvGZU/CkEP8IVEgb03Ns=;
        b=3H99wQ0X2/S5/QU99qvnQJYj3GnNL9HsPhJWYbSO27YCszfCz9nqp62LUk5CzHTkyY
         VaXubfLu3pANaVVmqVD/bn9QMCDhvftVkfjoQ8QpBtsKEL2eDkdKXTNQR7NfOOKJag1S
         aWynKVGaDaP7YU7G9CtBIo/U8mN0vkz2OqgjjdkuE5X+2O5LgiidR1SDGKSUvYnE//sj
         sYxwLFjvu8sGdOwlnksqtNXe1KNRGjMQY/CyIkIcrV3KWf/t33/B3i5JYb59FqNcXMMP
         Zzubq8GTM6AohqmTWvRREH3KzbalCvQ8tpVtcxMZXU/CGmCFSUsTXQ+kMxXZ89ph06TP
         CCAQ==
X-Gm-Message-State: AJIora/uibrIVCbgnnTVBkVtvnGkTzQh7MyNS6nkQaFwDWyhHiBFNTjO
        4+7Gf6Hts25yzeMyl8phhPc1E+9OA/gNlMOWci7TtGOVV6SW
X-Google-Smtp-Source: AGRyM1uL+VYsH0pCraYwusMGeK5T2zcBsSbrq4QTww10/UETdQyFMA7xur6fexRTbGY+hYUlPhC5NnN10pkTXmLjwG6lyBDdOcw1
MIME-Version: 1.0
X-Received: by 2002:a02:ac0c:0:b0:339:c958:ca85 with SMTP id
 a12-20020a02ac0c000000b00339c958ca85mr1622365jao.305.1656136809496; Fri, 24
 Jun 2022 23:00:09 -0700 (PDT)
Date:   Fri, 24 Jun 2022 23:00:09 -0700
In-Reply-To: <0000000000004b03c805e2099bf0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ad3d705e23f66ae@google.com>
Subject: Re: [syzbot] WARNING in folio_lruvec_lock_irqsave
From:   syzbot <syzbot+ec972d37869318fc3ffb@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

syzbot has bisected this issue to:

commit cca700a8e695fbe4a647e3a509ac513f05d5740a
Author: Muchun Song <songmuchun@bytedance.com>
Date:   Tue Jun 21 12:56:58 2022 +0000

    mm: lru: use lruvec lock to serialize memcg changes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15abaf18080000
start commit:   ac0ba5454ca8 Add linux-next specific files for 20220622
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17abaf18080000
console output: https://syzkaller.appspot.com/x/log.txt?x=13abaf18080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12809dacb9e7c5e0
dashboard link: https://syzkaller.appspot.com/bug?extid=ec972d37869318fc3ffb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d0f470080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1145df0ff00000

Reported-by: syzbot+ec972d37869318fc3ffb@syzkaller.appspotmail.com
Fixes: cca700a8e695 ("mm: lru: use lruvec lock to serialize memcg changes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
