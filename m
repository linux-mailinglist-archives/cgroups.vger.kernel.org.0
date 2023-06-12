Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD672CBBE
	for <lists+cgroups@lfdr.de>; Mon, 12 Jun 2023 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjFLQn3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jun 2023 12:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjFLQn3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jun 2023 12:43:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91719E5F
        for <cgroups@vger.kernel.org>; Mon, 12 Jun 2023 09:43:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-662f0feafb2so3277359b3a.1
        for <cgroups@vger.kernel.org>; Mon, 12 Jun 2023 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686588208; x=1689180208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSV7+xvV5iYIhAuD/TdxXQ0uoSNJAzoI8nkQ5nx/4IQ=;
        b=fkFecxV1NYBDKnFaAQR3ysyLgpxySSGwCkryf+lKhqEMLobraMIfhY2lKpsijiGcBq
         hLMzGpZ7bKcExpAsP1pfBTE5i1Hgd3Qz7o7Wmt7Osz57lbhf12t49H8hBp0uSOznmVMx
         UVc5tYcZNB7HMDKAv8de2YMuAB8izi78/zWW7GJWj353sDvMfY5czYGqVuS8XIMQkkxd
         5tTrcPsWzHThsCIp5GR2ZTfP4dMUlK+oklC2MII1HRQahBRlSRRhgeWFMXBS4gWWsfDt
         XUUpxX3aMWNtVUKGFN4T8W4LIQxz4aOFSjdyNPCOaqzvwcOq1xLuO6f1/6GV1C2Mbdz8
         eepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686588208; x=1689180208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSV7+xvV5iYIhAuD/TdxXQ0uoSNJAzoI8nkQ5nx/4IQ=;
        b=MKy/AtKYUgiO0xrxLoEuJZ4N43ikAQcHzk9A85GH4JAuoW7rGEx8amJ4OXMIT6D9ue
         ZIMLbPHEN5oTPE8lk6Ra5LiWysXGqQZHtXs0CZXMW1BvBTrjqJowUYX5rtaf9pvd9cLf
         9Pa8rDoNuj+/+z7t+WE8xe0Y3LcvwOdyIXrROU7oOSr/syugkUKJHVsgl3BudhJOZMZQ
         vegMgnm9l867ej4v337045J7J1+X1uXV7Bw0WFkcvJxMjCaykK3jGDkspmCBcOoMh+Sp
         uAcLa6pW+RfzRgx6Y5ohYjHp2EWyJqkP4c311sbZWe3k36vZg9gk6IHIcSzSCA+iPWsb
         kJeA==
X-Gm-Message-State: AC+VfDwxzaT7y+S8yq+4M/J5Z99lvC0/oTJlq7p83YLXoGZ8m+duqNBC
        fgZa5yGSS/YB13G/p+qyOCg=
X-Google-Smtp-Source: ACHHUZ6L2K4Y6unKxeptsoy7b+XArEAjEI5e8Fo5l6U55CjQoMkjsPbZAvY1QxQ4rVR49uhtG/2ZXQ==
X-Received: by 2002:a05:6a00:1952:b0:662:3edb:4376 with SMTP id s18-20020a056a00195200b006623edb4376mr10935411pfk.6.1686588207688;
        Mon, 12 Jun 2023 09:43:27 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id p26-20020aa7861a000000b0063d24fcc2b7sm7109034pfn.1.2023.06.12.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:43:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Jun 2023 06:43:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH] cgroup,freezer: hold cpu_hotplug_lock before
 freezer_mutex in freezer_css_{online,offline}()
Message-ID: <ZIdLMv-ayau220Mp@slm.duckdns.org>
References: <000000000000bd448705fda123f5@google.com>
 <000000000000d1565005fda9cef1@google.com>
 <69ab449f-1981-2d53-79fb-b2ac91ea9cef@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ab449f-1981-2d53-79fb-b2ac91ea9cef@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jun 11, 2023 at 10:48:12PM +0900, Tetsuo Handa wrote:
> syzbot is again reporting circular locking dependency between
> cpu_hotplug_lock and freezer_mutex. Do like what we did with
> commit 57dcd64c7e036299 ("cgroup,freezer: hold cpu_hotplug_lock
> before freezer_mutex").
> 
> Reported-by: syzbot <syzbot+2ab700fe1829880a2ec6@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=2ab700fe1829880a2ec6
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot <syzbot+2ab700fe1829880a2ec6@syzkaller.appspotmail.com>

Tagged w/ the same stable version as the earlier patch and applied to
cgroup/for-6.4-fixes.

Thanks.

-- 
tejun
