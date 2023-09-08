Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01924798C3D
	for <lists+cgroups@lfdr.de>; Fri,  8 Sep 2023 20:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjIHSHJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Sep 2023 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIHSHI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Sep 2023 14:07:08 -0400
Received: from mail-pf1-x447.google.com (mail-pf1-x447.google.com [IPv6:2607:f8b0:4864:20::447])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E42E26B5
        for <cgroups@vger.kernel.org>; Fri,  8 Sep 2023 11:06:44 -0700 (PDT)
Received: by mail-pf1-x447.google.com with SMTP id d2e1a72fcca58-68bec43ec0cso3285727b3a.2
        for <cgroups@vger.kernel.org>; Fri, 08 Sep 2023 11:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694196270; x=1694801070;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lAvPiHpQzYJH2/Evbqeae0jEIobBXd5mkIT/JR5mjU=;
        b=rUgJ9kX8jWYv4zyR7za2Whgc2F+nR9oGmJD3t1N6pIhqlqFLtjx22f31O3Ar8y1x75
         Y3W/WtVhB9mLWPEeOONMYjqYQvx3GfgfLcUnjBh8q4vHYaZtRYsRtco78ZiiXmwpFm0P
         B+6QIbS3C4imYvkgo3A3YWesQe87KxKA6gSq6dagqX658ERXS63IIfbvAB/axAZGhKpL
         t+hsrZEJTHwY5WCCWviIP/t/Lxi6O0Dr/iKmrdBTOw0H8y7ScFnNRJ4CMogqUtRC5bsT
         ssAjIQ1DTkaL7dsuD0TM4qrKz/LrdyTjN1NRINy/gcv+5KKq531ILxtY1bnVVae+yjoF
         2QMA==
X-Gm-Message-State: AOJu0Yy+r2G0dQC8JEFwe322bXQimzs7uDh60Np/kYTvV0LDD0BYTLrM
        XjMBjKzoXidrPtRRFo/kYWXuOQh5etcukfa52wdvRWa2ZxVM
X-Google-Smtp-Source: AGHT+IFG6oZqBOayFovKE0NVKEQ0Xnwtd+Nskzg2qKPXIoko6vfMv+elInHkBKWJh6QlQckbllDdPD2ESA+Mlnx+N1cgB86kBYBd
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:80c:b0:68a:3c7a:128c with SMTP id
 m12-20020a056a00080c00b0068a3c7a128cmr1357477pfk.2.1694196270440; Fri, 08 Sep
 2023 11:04:30 -0700 (PDT)
Date:   Fri, 08 Sep 2023 11:04:30 -0700
In-Reply-To: <000000000000f392a60604a65085@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e127ec0604dcce27@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
From:   syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>
To:     42.hyeyoo@gmail.com, Liam.Howlett@Oracle.com,
        agordeev@linux.ibm.com, akpm@linux-foundation.org,
        alexghiti@rivosinc.com, aou@eecs.berkeley.edu,
        borntraeger@linux.ibm.com, cgroups@vger.kernel.org,
        christophe.leroy@csgroup.eu, damon@lists.linux.dev,
        david@redhat.com, eadavis@sina.com, frankja@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        hannes@cmpxchg.org, hca@linux.ibm.com, imbrenda@linux.ibm.com,
        jeeheng.sia@starfivetech.com, jglisse@redhat.com,
        kvm@vger.kernel.org, leyfoon.tan@starfivetech.com,
        linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mason.huo@starfivetech.com,
        mhocko@kernel.org, mpe@ellerman.id.au, muchun.song@linux.dev,
        naoya.horiguchi@nec.com, npiggin@gmail.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, roman.gushchin@linux.dev,
        sebastian.reichel@collabora.com, shakeelb@google.com,
        sj@kernel.org, surenb@google.com, svens@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

syzbot has bisected this issue to:

commit 49b0638502da097c15d46cd4e871dbaa022caf7c
Author: Suren Baghdasaryan <surenb@google.com>
Date:   Fri Aug 4 15:27:19 2023 +0000

    mm: enable page walking API to lock vmas during the walk

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fd2348680000
start commit:   7733171926cc Merge tag 'mailbox-v6.6' of git://git.linaro...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13fd2348680000
console output: https://syzkaller.appspot.com/x/log.txt?x=15fd2348680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b273cdfbc13e9a4b
dashboard link: https://syzkaller.appspot.com/bug?extid=b591856e0f0139f83023
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d4ecd0680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1055c284680000

Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
Fixes: 49b0638502da ("mm: enable page walking API to lock vmas during the walk")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
