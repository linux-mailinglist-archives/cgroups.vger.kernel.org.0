Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512E526715
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2019 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfEVPo0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 May 2019 11:44:26 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:38146 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbfEVPo0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 May 2019 11:44:26 -0400
Received: by mail-pf1-f177.google.com with SMTP id b76so1540011pfb.5
        for <cgroups@vger.kernel.org>; Wed, 22 May 2019 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z2dsucXEI+4jvL/MdjM5V2xnzon5dvV20hzmst7SI+w=;
        b=QEF+zn6btGpaZqM8f+IKFYqUq9v/Z7nVJc5hwB7Rsx3ybr7C3yoYL92vIvxi9L/hgY
         ZMJ2Ji1yspXAzrAVJ3ADZVQUDcRvEOYsYWQBuaz6bO8miAOlYzoQKQkjOrwC/3tsKjYx
         A4d4jMapVv1bxyua1ChiqHYxhX48A/3uMN1NVH72O/e+tS9Dc3scB9aTEvEvGtjoZi+Q
         98SilnjsnWbW5QH/Bu9WxnIr73P0RyENw74jrmzwv/TG7BUbTqTqZTdG+XUQetFvizXG
         Nclj6JQyDVN70kl/TrSbnI9SyIJtVv8O2G03D/AF5+UjVBLd9OEFjO9HIUrL3bVqgACM
         X8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2dsucXEI+4jvL/MdjM5V2xnzon5dvV20hzmst7SI+w=;
        b=Hf5pHiDTarPQnk+YuUeII77x1p1UnrmGGKaa9qp5DY5MZBHfkAjQ90ayFTRVG1hkwV
         aCM+hn3X9bFBpUUcTfUpSns8EKKu/KdmwmPKiYZBgJSbqkoaedH+TbX8yucRel/V4ydb
         NwvcqflqPDaS9TYcDBesAFuwIlBn1kKF3G6NqvWho4FlIayp7Yg7Yi8lhrWiMCOeMi/m
         Y8kz75nVsC+eVEuJikSaTv+u7OdaZ0J/NnPNQ4L9f/4uNobl5N/xFSFpnqJEnk8e/2e3
         44aG5r65sNiiVWpNEUkh1Rff0SJwrG9FW5+XCCi+k0hZRx/bzcAQ08hjKdkakSZUkuIi
         Mw9w==
X-Gm-Message-State: APjAAAVX1RXHVDSTWmh8TmHSbC/kbKOFn53arCy3Eb21iu+v4GDtco0Z
        pcdvUTRwAI51MID/o2AL7cFWMg==
X-Google-Smtp-Source: APXvYqwNhNcpWibI4Oqtyib2hlUbtVFt/lmAsL6lT2SW95cEyZw8qdJilZn5xKkTMIfePZ7Vf2JUHQ==
X-Received: by 2002:aa7:99c7:: with SMTP id v7mr97012872pfi.103.1558539865858;
        Wed, 22 May 2019 08:44:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::ed6d])
        by smtp.gmail.com with ESMTPSA id j184sm25079831pge.83.2019.05.22.08.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 08:44:24 -0700 (PDT)
Date:   Wed, 22 May 2019 11:44:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, mm-commits@vger.kernel.org,
        tj@kernel.org, guro@fb.com, dennis@kernel.org,
        chris@chrisdown.name,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: + mm-consider-subtrees-in-memoryevents.patch added to -mm tree
Message-ID: <20190522154423.GA24972@cmpxchg.org>
References: <20190212224542.ZW63a%akpm@linux-foundation.org>
 <20190213124729.GI4525@dhcp22.suse.cz>
 <20190516175655.GA25818@cmpxchg.org>
 <20190516180932.GA13208@dhcp22.suse.cz>
 <20190516193943.GA26439@cmpxchg.org>
 <20190517123310.GI6836@dhcp22.suse.cz>
 <20190518013348.GA6655@cmpxchg.org>
 <20190521192351.4d3fd16c6f0e6a0b088779a6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521192351.4d3fd16c6f0e6a0b088779a6@linux-foundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 21, 2019 at 07:23:51PM -0700, Andrew Morton wrote:
> On Fri, 17 May 2019 21:33:48 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > - Adoption data suggests that cgroup2 isn't really used yet. RHEL8 was
> >   just released with cgroup1 per default. Fedora is currently debating
> >   a switch. None of the other distros default to cgroup2. There is an
> >   article on the lwn frontpage *right now* about Docker planning on
> >   switching to cgroup2 in the near future. Kubernetes is on
> >   cgroup1. Android is on cgroup1. Shakeel agrees that Facebook is
> >   probably the only serious user of cgroup2 right now. The cloud and
> >   all mainstream container software is still on cgroup1.
> 
> I'm thinking we need a cc:stable so these forthcoming distros are more
> likely to pick up the new behaviour?

Yup, makes sense to me. Thank you!
