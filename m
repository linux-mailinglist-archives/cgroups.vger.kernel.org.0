Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1345A463BA3
	for <lists+cgroups@lfdr.de>; Tue, 30 Nov 2021 17:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbhK3QZq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Nov 2021 11:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbhK3QZq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Nov 2021 11:25:46 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE3AC061574;
        Tue, 30 Nov 2021 08:22:27 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id bu11so18533710qvb.0;
        Tue, 30 Nov 2021 08:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gnE15tK2SlVmlypqM3RW5c3jzy7f6IwXtXXTaXhAYrU=;
        b=QUqWIHsgW8VZgRjl3ETtFZ9h1EaF+0J0+neEaUQmeCLl/WG/zEHT2o0TojSLjWTgm6
         wWNyB+FcdsJkpN11UGV/6BYPY8MlWTk5eW/7KGXbfaGY6xZXH1GGs0AdgIK0Pph7n+6A
         wkjg8aPKIkvJuHx13tI24PzSDu6bJFEyYvGywNqjnLjaJ2xoRY5aOVJkNf6cgINKkxYU
         /W0i9lhNXLRfZuozHGKFSOEth7mfxsfRcpyCoU5zHc5DxfgEQaU5fi1TTS2vst5B15cm
         lO/gTkDgDar7T1Ilv2ZGa+m92HSVhDB7C7gLMgg65xm+/OdJrpvNd3Jg6DBus5VRG3VB
         1UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gnE15tK2SlVmlypqM3RW5c3jzy7f6IwXtXXTaXhAYrU=;
        b=4852OlwZefqfY73woUWPMzM6HwHhFhFK1D3Syu+fUk49HpF4arTpjY1fmhhw/D2XuJ
         BVqzhOFGZUZ+oeU1UWz7pvCqdjkr6AU7K99A/Wge+SSCScnpbcQFvRhBLspl31kizjbv
         vDxmYazbUqPOWs36nNBHkgUtGaMMvY3o1gqISV1RfmkLkzNqNUqWWjQQ4eGGiTcMtFAm
         k3RidYgcZQfF1Io78VZf3PL1jrME0WHYMSjPYiq29iwcZZYBVY0wTBvGvLoKNPpMb8tZ
         QZaM1VFm+muT+teS+2gSc7YmJ8Df6tMo4syreWihrcBRjMpCibwQODJhYWYEqW2pGhY2
         GcmA==
X-Gm-Message-State: AOAM530aWfrvukCwnOsCX5LLTt7JuSrRVUUBUS4UKfdkawTgnvO1LCdz
        Po12tdxlxxTvrDWH2MnuZpnlmYAtwp9QkA==
X-Google-Smtp-Source: ABdhPJwOtk0oasb7ELDuwkPIDRdbTiwVjz4GDn2HC8+exUo/+j9VaW8jtr4i67vzC+UhZSoYh8B/yw==
X-Received: by 2002:a05:6a00:21c9:b0:4a7:f071:eb73 with SMTP id t9-20020a056a0021c900b004a7f071eb73mr217478pfj.23.1638289335493;
        Tue, 30 Nov 2021 08:22:15 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id o1sm2980590pjs.30.2021.11.30.08.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:22:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 30 Nov 2021 06:22:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, fvogdt@suse.de,
        cgroups@vger.kernel.org
Subject: Re: Use after free with BFQ and cgroups
Message-ID: <YaZPtZcdMKwhzzy/@slm.duckdns.org>
References: <20211125172809.GC19572@quack2.suse.cz>
 <20211126144724.GA31093@blackbody.suse.cz>
 <YaUKCoK39FlZK9m5@slm.duckdns.org>
 <20211130115010.GF7174@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130115010.GF7174@quack2.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Nov 30, 2021 at 12:50:10PM +0100, Jan Kara wrote:
> The problem is bfq_queue associated with a task effectively holds a
> reference to the potentially dead cgroup and the reference can stay there
> until the task (that itself got reparented to the root cgroup) exits. So I
> think we need to reparent these bfq_queue structures as well to avoid
> holding cgroup in zombie state excessively long.

Ah, I see. Yeah, that's not great. Agree that it'd be better to reparent
(probably just punt to the root cgroup).

Thanks.

-- 
tejun
