Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195894EB884
	for <lists+cgroups@lfdr.de>; Wed, 30 Mar 2022 04:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbiC3Cyo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Mar 2022 22:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242138AbiC3Cyn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Mar 2022 22:54:43 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960D717F3F5
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 19:52:58 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o17-20020a92c691000000b002c2c04aebe7so10676717ilg.8
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 19:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=QTWd4i/NLWNwVTetwl9CtbJr/No1iCLKabQJftIK/JA=;
        b=ZkHWuhudienvgJXQz+Q7rnLhwITIXPEiOCro/pR9ORfKKaaYceC747zpbcfCX9tiyB
         rCGZhpx+yb5EuQrJZyTJ+7MrO/OOqy17vW3pRQQ+jr0IGGFH2BmA1Vm00gXZ8Ss4yc3q
         /qdSOtZOnGD17W5FezFqbcCwY0u6Xp2ZgEu6v3K/jF7HAiZFGjECtMFAzQoAb+Qpj2Vp
         kKf2irLUuRKZSbYHsr6fw1MNKJOW7aYkJxmRA8U1Hx+8ZrI0k52TcJJJTKCyjxZ5L6Sj
         ODikxcJOKigBiuaerUKoOK6k8xvTKU92qvlYrYvivqxEes/vVZW9ha40rpPf3Ukzbi9F
         jSYw==
X-Gm-Message-State: AOAM531FEcZnHZVPLIE4okpH/PT0MWZYeTsHeGXNDRku06kqvo08by/F
        h6irEXW9KV/xL6jogw2QR7kiH84ex6p4CxFXD6H+ei1MQHqs
X-Google-Smtp-Source: ABdhPJyq9cQJoYCYrKX1O1yqGx4xWLqI4SbSujkC+1zs14yfWnJqdT9ztdF8dPSAxYZS5ZRJPB7UCGp5tHB/P7vcWu8eb6aUgH5Y
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3043:b0:314:7ce2:4a6e with SMTP id
 u3-20020a056638304300b003147ce24a6emr17819523jak.258.1648608777933; Tue, 29
 Mar 2022 19:52:57 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:52:57 -0700
In-Reply-To: <CAFj5m9+Gc-t6vD17yWBNos-fk9vmhUTLsXYGrSx4Bdzn7R67JQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009518f205db66a47a@google.com>
Subject: Re: [syzbot] possible deadlock in throtl_pending_timer_fn
From:   syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> On Wed, Mar 30, 2022 at 5:23 AM syzbot
> <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    cb7cbaae7fd9 Merge tag 'drm-next-2022-03-25' of git://anon..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17ef8b43700000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7094767cefc58fb9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

This crash does not have a reproducer. I cannot test it.

> for-5.18/block
>
> It should be fixed by:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.18/block&id=d578c770c85233af592e54537f93f3831bde7e9a
>
> Thanks,
>
