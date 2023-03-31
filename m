Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0576D2865
	for <lists+cgroups@lfdr.de>; Fri, 31 Mar 2023 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjCaTE2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Mar 2023 15:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjCaTE1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 Mar 2023 15:04:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50B62293F
        for <cgroups@vger.kernel.org>; Fri, 31 Mar 2023 12:04:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w9so93602138edc.3
        for <cgroups@vger.kernel.org>; Fri, 31 Mar 2023 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680289464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBgtdWro37xy0xED7gYpWdnIpcRD6CvxaVJDB91GKvs=;
        b=fL6JQwfkCzg5k8MIp2yW1eevTYpumo4axpAUWjeQVnxZ023oShCKTwLmnAc/fye6xx
         neR98ZJVj6piv4J9ecd7xjjIQYyACuTq59qmaCS3yTQOGPhA91OF92s4v9CkBWSpvvKM
         rz65GCEGOOJ8yjBjMqwAS3b3tgCOZKNxFJajWQaJRjRdc4CSg/cA57O8D+Oq6Oe1LAJ4
         2mVn/cvkii1QVT3GcQW/mRwIrCzXmOwHpOMN8C/onm9XRgMZ288OdnZgwdQUr7MMj8+8
         RRbSZfC/Y3QYlXMJZsdEzOOnNaU20+AvLyLZyFhObvmRedEK5bFf9W0VpJPo3NjJ/PlU
         ADqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680289464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBgtdWro37xy0xED7gYpWdnIpcRD6CvxaVJDB91GKvs=;
        b=VIwgsEEIfwEhDTfxQBXwWrhIHSFAicbHRbfTUfKB74djITC08ijKKHfowH+3+lKwIp
         VnAcF9orTzoZJDPL2dyN4mC7NoDi9EpkpPIeXonfVcWG8V+kbbQ4YgQSbRrze+5WfCx5
         rmRBcipp2pAqcx6hOY58BF4y71fsEU89vEGNf/TtJ3CNadiAKXiRybpC2IM2CibbiSCU
         o7r+nVGtnCy+B01iS2fW3pGEC0oCbDI2umjNHHRATEh+GNC+6aeu/U8V3JZiT6ZnpoKf
         G3jNGsy5aSL8QJcCzXw+8Wh9hgKJNSROntAPaQKqUMr8sXeEzS1H2+ZYoKbLxHDqvCGN
         PXtg==
X-Gm-Message-State: AAQBX9eEaQrC67Fl1OjrEYYzLmz2JOEaCPIlfKt+MYHKtpy2MKqsUt+q
        bsTvzY663e2rkEIslDlmjlg+3ZV7aEdJfw5bJspyIA==
X-Google-Smtp-Source: AKy350Zu5bBwTsywOca+UGIcS/HARlLbeBWAVVNB4lZtMspaiROXuzs3nwneenpby7qGskVTJooNUd+2uG/N2dk1CQM=
X-Received: by 2002:a17:906:2456:b0:8e5:411d:4d09 with SMTP id
 a22-20020a170906245600b008e5411d4d09mr14495139ejb.15.1680289464033; Fri, 31
 Mar 2023 12:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkb-UpKm2QbjYzB=B=oGk6Hyj9cbUviZUPC+7VsvBecH7g@mail.gmail.com>
 <20230329192059.2nlme5ubshzdbpg6@google.com> <ZCU1Bp+5bKNJzWIu@dhcp22.suse.cz>
 <CAJD7tka0CmRvcvB0k8DZuid1vC9OK_mFriHHbXNTUkVE7OjaTA@mail.gmail.com>
 <ZCU+8lSi+e4WgT3F@dhcp22.suse.cz> <CAJD7tkaKd9Bcb2-e83Q-kzF7G+crr1U+7uqUPBARXWq-LpyKvw@mail.gmail.com>
 <ZCVFA78lDj2/Uy0C@dhcp22.suse.cz> <CAJD7tkbjmBaXghQ+14Hy28r2LoWSim+LEjOPxaamYeA_kr2uVw@mail.gmail.com>
 <ZCVKqN2nDkkQFvO0@dhcp22.suse.cz> <CAJD7tkYEOVRcXs-Ag3mWn69EwE4rjFt9j5MAcTGCNE8BuhTd+A@mail.gmail.com>
 <ZCa9sixp3GJcjf8Y@dhcp22.suse.cz>
In-Reply-To: <ZCa9sixp3GJcjf8Y@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 31 Mar 2023 12:03:47 -0700
Message-ID: <CAJD7tka-2vNn25=NdrKQoMf4ntdbWtojY0k4eAa-c9D+v7J=HQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 31, 2023 at 4:02=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 30-03-23 01:53:38, Yosry Ahmed wrote:
> [...]
> > Maybe we can add a primitive like might_sleep() for this, just food for=
 thought.
>
> I do not think it is the correct to abuse might_sleep if the function
> itself doesn't sleep. If it does might_sleep is already involved.

Oh, sorry if I wasn't clear, I did not mean to reuse might_sleep() --
I meant introducing a new similar debug primitive that shouts if irqs
are disabled.

> --
> Michal Hocko
> SUSE Labs
