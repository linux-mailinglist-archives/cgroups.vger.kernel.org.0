Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49B835DE4
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfFEN0M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 09:26:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34755 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfFEN0M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jun 2019 09:26:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id t64so5106407qkh.1
        for <cgroups@vger.kernel.org>; Wed, 05 Jun 2019 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s6/pRA/FRv79XWIPs0xt9Lyo0lf431cIWjT6TfF1xds=;
        b=k8/Yhbufqh3DMYmLycwsD4rntibzmwGLFA8f3BJkBHYziNLbAiTWTtNHG8P/LZXG01
         RQr3TuUc7en2wLHZVCPQyU8oTGqg0hN3O3VhWzUdlsZgq7nvJBBc1wHtWnsIISh87nJl
         tS4mJTrZk63Xn57xRtEf92yZctuaIVJ9RbJRB40XHVYqSOUn5EPxrnw+KvvV+eojCNNs
         26TIF/qMy/wLikOWhz0zJ0Z6oQe57wex1ly57qgu8408/ZLDG/a9ZMHgEhxIVSzHjg5G
         Ah3XhcGeFc/9gT1+wfPOSFQXBxqU9Lm38xTZvkjCj1L7OEGQRoec2kC1w/+rf8Qg82FY
         b2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s6/pRA/FRv79XWIPs0xt9Lyo0lf431cIWjT6TfF1xds=;
        b=TR3KMtvxk50jaNuw+nANBFHeXpfwS8aeDtxqj+HocR9sxirBJXnM1yGHYs7alBVgxm
         R5q6WyLcnuSRUGtZ39TM8tDCb2E90l3NrQZ4PH6x54LFF+aqhBC23BZzF/Av003vMpEf
         37pTMoYGBOglVVAyNk0ctvkZ4gzBx6JXMQb6IOs/oas9JZurkNHkEYr3jij3B2EdANA/
         c6mnCob64qnYfK/CcJCbZWIEMv20Ixst5HB1HSjpeGJNTRZWliUNRMntz4Nf1/LlLOKA
         c1mkUggWJUbUQ9eaGVDo/1GxFh3GAuKmKTy1QClAqRWRFiKWxr/IlWRgfwfMWBSNwfYQ
         FbLA==
X-Gm-Message-State: APjAAAUdEZCWQOT2689Q9QPVyePCLEpYIDRHJABk+J+X/Ltub8E5yxVM
        qUUmEth5xJJS+2K+03fL7fbcpY1E
X-Google-Smtp-Source: APXvYqyn/0YrgqYDxI+pyotnafRB07J91NtPSDC/hCalcKirkzsBwvMmzeYdvlDQDwYgHNmcrRVsuw==
X-Received: by 2002:a37:50d4:: with SMTP id e203mr31499108qkb.83.1559741171252;
        Wed, 05 Jun 2019 06:26:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c027])
        by smtp.gmail.com with ESMTPSA id o8sm7701628qtq.18.2019.06.05.06.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:26:10 -0700 (PDT)
Date:   Wed, 5 Jun 2019 06:26:07 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH for-5.2-fixes] memcg: Don't loop on css_tryget_online()
 failure
Message-ID: <20190605132607.GI374014@devbig004.ftw2.facebook.com>
References: <20190529210617.GP374014@devbig004.ftw2.facebook.com>
 <20190605125520.GF15685@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605125520.GF15685@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 05, 2019 at 02:55:20PM +0200, Michal Hocko wrote:
> On Wed 29-05-19 14:06:17, Tejun Heo wrote:
> > A PF_EXITING task may stay associated with an offline css.
> > get_mem_cgroup_from_mm() may deadlock if mm->owner is in such state.
> > All similar logics in memcg are falling back to root memcg on
> > tryget_online failure and get_mem_cgroup_from_mm() can do the same.
> >
> > A similar failure existed for task_get_css() and could be triggered
> > through BSD process accounting racing against memcg offlining.  See
> > 18fa84a2db0e ("cgroup: Use css_tryget() instead of css_tryget_online()
> > in task_get_css()") for details.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> Do we need to mark this patch for stable or this is too unlikely to
> happen?

This one's a lot less likely than the one in task_get_css() which
already is pretty low frequency.  I don't think it warrants -stable
tagging.

Thanks.

-- 
tejun
