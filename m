Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B102B78CDF8
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 23:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjH2VCQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 17:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbjH2VCE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 17:02:04 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC401BB;
        Tue, 29 Aug 2023 14:02:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c09673b006so25654135ad.1;
        Tue, 29 Aug 2023 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693342922; x=1693947722; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMyy3L586kb8cKfelvrLkGkpSHTkexvGQpQjE1LwdFo=;
        b=CyS5CPua06THdQxkbEFgECOylZrddrh+R/xL1V4Hgbp3Hp98GdIh394fmg3cEBkD4G
         31IuNUsJfa0D1IstYXy7U4jYmK5+fO0hXlKm6aWD/Tcu2lap9D55BoANYlnFxseYEGxS
         /caoQL8ZEsjObmP5rt/dgXpyl8bgoxPS8r3NpD6F7AEYq4DhYf03g/5zp98nmVY1kmvO
         CdcTRviQiLJAKOsbOXWzqhVsErGjFQFXVH8E5LaGeuI+TyDsO0OgXAjSnL+S04g67LnL
         2L4ufEIg+/53OGazOhUdQZNmPdXSL/2GsHeYoO4NFOw+jZF04peiGH0zNlmwEieLC34J
         W9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693342922; x=1693947722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMyy3L586kb8cKfelvrLkGkpSHTkexvGQpQjE1LwdFo=;
        b=DTj2+UMMnWJv0Buniuw2xC7hl56A/5tsGA5ATcdx/JLj3oCslltTQYfHNceHtDmsh6
         QjuCqUCgfoA1IywLxx5Y0jr2pByU0zzeonEZivk5hnt8hOdVcQ3rMTWAHs6cuIJS/T2J
         3gO3RijtkhgsMjRX669vlgLIpTOwBr6YJhHoq0fOcPojWY1/SgUeEwL1m9SKmmWuA/MJ
         1BvP4NZUurOHhU85oPSnEnR4GdAjzfFMwi1HjWwZUJ5yrc8GUMvQ5SqiHVeFZktT+VFR
         MCL+uVL7SqGgbmxsNGt2MPRlGqcsYtnESrfEGJO61Etwbkj0/ZBqJtufwFdC7MynW3Rg
         sDQw==
X-Gm-Message-State: AOJu0YzmW5BBdN5iN+I2KXBnsN7l37tfj/VQRH402mS+JlRCl1wcrPEC
        OUDw6bMkrS7Pg+3o4+wCuto=
X-Google-Smtp-Source: AGHT+IGAgnDe30iZda737JpeCWLLIfCE0Xgd3FyeVLQqqjM+mbrYjt/hp5on64LCBTGZqmA1uSSheA==
X-Received: by 2002:a17:902:db08:b0:1bd:e64c:5c70 with SMTP id m8-20020a170902db0800b001bde64c5c70mr285730plx.7.1693342921671;
        Tue, 29 Aug 2023 14:02:01 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001bdd7579b5dsm9787431plg.240.2023.08.29.14.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:02:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Aug 2023 11:01:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Firo Yang <firo.yang@suse.com>
Subject: Re: [PATCH 1/2] cgroup: Print v1 cgroup.procs and tasks without
 pidlists
Message-ID: <ZO5cx9UhqBzP2QX-@slm.duckdns.org>
References: <20230823174804.23632-1-mkoutny@suse.com>
 <20230823174804.23632-2-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823174804.23632-2-mkoutny@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Michal.

On Wed, Aug 23, 2023 at 07:48:03PM +0200, Michal Koutný wrote:
> pidlists are structure that allows printing cgroup member tasks in
> sorted order and with proper pidns (in)visibility.
> 
> The promise of sorted output was removed in the commit 7823da36ce8e
> ("cgroups: update documentation of cgroups tasks and procs files") (more
> than 13 years ago at the time of writing this).

While this is true, I'm not sure it'd be a good idea to change the behavior
after all these years. Whoever is still using cgroup1 likely doens't mean to
update their code at all and it's difficult to rule out odd-ball users that
might have been depending on the ordered output knowingly or unknowingly.

> On systems that still use v1 hierarchies (e.g. systemd in non-unified
> mode), pidlists are problematic because:
> a) their cache unnecessarily busies workqueues (cgroup_pidlist_destroy_wq)
> b) PID recycling [1] may lead to logging noise:
> > seq_file: buggy .next function kernfs_seq_next did not update position index

While I like the code reduction, I wonder whether the right course of action
is just fixing the warning here.

Thanks.

-- 
tejun
