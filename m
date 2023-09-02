Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38C5790891
	for <lists+cgroups@lfdr.de>; Sat,  2 Sep 2023 17:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjIBPop (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Sep 2023 11:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjIBPoo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Sep 2023 11:44:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A1FCFE;
        Sat,  2 Sep 2023 08:44:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c0db66af1bso195245ad.2;
        Sat, 02 Sep 2023 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693669481; x=1694274281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5MqIon8Nabrk/UvYJeaLuN2bLyxr6GffPmpVBNQNzY=;
        b=kiLwbzmxJjaPyaP+zIeuBKcch+lT4I5zcV6AcLFOt8haFUU1QSm8vpV8jnhWLw+N75
         etueSPHbbEcA9+rM/Epy6pIh9Y0ltgLZHU9w6zi6SjPvbiMbobIWh3kNJQH/8sOPYfET
         0/dsdMe+7aqtA8dO0h0a0NTZyUsplhB4aj0UbDgrTi3wQn6jcyByeCLSLWLid+6Idang
         d9fug9sfOz26Bd74Bj7iTE2cqK82KvI6JUc6FfYwJOlmyrskGIJHFN1Y5pvNGGIuBftj
         Cqkax6SbL0J8ue3kmFOzVVrqw2hcI2J0iNmyRDYrsFbo5xa7zMFVxwGYy5xOzcY5tWum
         y8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693669481; x=1694274281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5MqIon8Nabrk/UvYJeaLuN2bLyxr6GffPmpVBNQNzY=;
        b=Z1y06LxiPjxHxQgQMwY42+cXFR6m8IiNG0QCWwaiJFgCqnlooK5r3eHoggYA6CXbSF
         s/OFz+jfRuYOVSmS9m4+KFqMvimksM/qpopHTeXbqIOVkhvVLTADtJfs6J4TStPgj7PU
         5Q83g3zimgj++56lVTMbrP6qnnGOlOUdHuIWkYvJFYA2/QCxvLQuEC9P/xpSEsRj9jgM
         aveGObROwYOCFfqn4n4SycfUks0fX5t8yPJWe3TXaNP5mJOFgkv+lf8BmTIh9YdKntdf
         2/BGz+EJZRzSu4v8qCIg8S9wcYguv3WzuT4eYa/2THeOCDT974kWQ9U4dcHbxtVRdTM0
         3z0A==
X-Gm-Message-State: AOJu0YwycPes+0g650JLkgcpkPw5GbUGNq/47Vl7+RnDtx5BDbxkoO6n
        6ThwflHxOobEXa60fqKDmCg=
X-Google-Smtp-Source: AGHT+IGcBMkV457o3ML4vRJH+8WU9TjzwVYKJ5GtcOPGFgZvYZ1JSFh3URPE+iNYyEfnC0CaeAZMcw==
X-Received: by 2002:a17:903:26ce:b0:1bd:f1ae:309d with SMTP id jg14-20020a17090326ce00b001bdf1ae309dmr4955077plb.9.1693669481269;
        Sat, 02 Sep 2023 08:44:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:eca7])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902d34900b001bdcde49bc3sm4802471plk.119.2023.09.02.08.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 08:44:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 2 Sep 2023 05:44:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: mainline build failure due to d1d4ff5d11a5 ("cgroup: put
 cgroup_tryget_css() inside CONFIG_CGROUP_SCHED")
Message-ID: <ZPNYZ8quPOdJeVa2@slm.duckdns.org>
References: <ZPMdTJ7zwrCkdMTu@debian>
 <CAHk-=wgmvf9OjxeiO7ZzN2hsmDZ7-HViP9AjQkRN84fuDXNATQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmvf9OjxeiO7ZzN2hsmDZ7-HViP9AjQkRN84fuDXNATQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Sep 02, 2023 at 08:37:38AM -0700, Linus Torvalds wrote:
> On Sat, 2 Sept 2023 at 04:32, Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > git bisect pointed to d1d4ff5d11a5 ("cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED").
> 
> I pushed out a commit that should fix it (76be05d4fd6c: "cgroup: fix
> build when CGROUP_SCHED is not enabled")

Ah, you beat me to it. I'll drop my fix branch.

Thanks.

-- 
tejun
