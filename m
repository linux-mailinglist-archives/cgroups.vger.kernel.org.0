Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F134F30F7DC
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 17:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbhBDQ2l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 11:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhBDQ1P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 11:27:15 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54778C061788
        for <cgroups@vger.kernel.org>; Thu,  4 Feb 2021 08:26:34 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t63so3897192qkc.1
        for <cgroups@vger.kernel.org>; Thu, 04 Feb 2021 08:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ACIgalIASwLRIdWMuW6Oj7uCmIS5PMrqjcUMfzNwZKE=;
        b=MhxcF478bHTzeOjaqn3t+dgrOQ2TemimDwkXVDLohFRJNl95pHbGa9lLMm7eUh47yK
         hqGCwPMieGsvldBevk/GTzZFLDZryCRd8tlWXVG8uYNf9AohQdvgTb+LxFJwSEjutywo
         3E18OctPqEd11DhJx4NgXE4Yj0fHAQ0WIyhu+wgSKgvMnTRsuVjDtnLBrLvkb4TXY9Om
         LcJVZVFkYyCc7nEmtuJiow7He54ZkAWBEXGmmJe/6WxLOur+I/zZe0/QnliUXFYnnBc3
         +cNlrBxAgNgbdTKF95BPokovA+P0SqJ0wm/w/bqBYg83pfhDJKy0DV+MBi+sqDRpT+Bx
         ZldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ACIgalIASwLRIdWMuW6Oj7uCmIS5PMrqjcUMfzNwZKE=;
        b=dxGgEfluRN9eZ9GGtkFeSkZovMgGOlgSjnuVMbQXilrVGhiKlrKe7RU6yVSyqTEGRZ
         u80BIpsBFRvtAYn/7L4360n5iErbQD7lOwd5cgtx06zEe7CjTinz20rb1bJsLUeASncX
         QaxsKXEzKD0NQRbihD3/HoKzgXATWlGCaLqXreGD2S5dCZKzOKYHX9+VhFG4zeqWyRs+
         A45LmJzYQ/FwdtjeT/C8HVO5LhLON5hF8DDRIbWkEVM1zEZmFTxV7a52/CJKB2zAozLg
         xaMppnoDYspQqG68Sr6sRE2q1+PMJe/XAldwjuVTv6TumDgNsK48ibrlkXoW1Y3sAt/O
         ZlhQ==
X-Gm-Message-State: AOAM531BVS5L/hTA6TEuRU1mFCinIi0Y7Js/v8gY3aVtdYb3Q61jgnN7
        rie+hEi0OMzGCowcwN4JiTD02w==
X-Google-Smtp-Source: ABdhPJxIV4CD4lGok1rJ7D4sC9j6L8cQiM/cMuIlBrELVi3sX2eGXEMa9a2jlGvNzQjeqYhitY/mZA==
X-Received: by 2002:a05:620a:5ae:: with SMTP id q14mr8254731qkq.156.1612455993552;
        Thu, 04 Feb 2021 08:26:33 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k25sm5549112qkk.66.2021.02.04.08.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 08:26:32 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:26:32 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <YBwgOHL8dTjJpnKU@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
 <20210203014726.GE1812008@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203014726.GE1812008@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 02, 2021 at 05:47:26PM -0800, Roman Gushchin wrote:
> On Tue, Feb 02, 2021 at 01:47:45PM -0500, Johannes Weiner wrote:
> >  	for_each_node(node) {
> >  		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> > +		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = {0, };
>                                                               ^^
> I'd drop the comma here. It seems that "{0}" version is way more popular
> over the mm code and in the kernel in general.

Is there a downside to the comma? I'm finding more { 0, } than { 0 }
in mm code, and at least kernel-wide it seems both are acceptable
(although { 0 } is more popular overall).

I don't care much either way. I can change it in v2 if there is one.
