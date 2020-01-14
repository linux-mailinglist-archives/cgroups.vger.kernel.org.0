Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30113A3D1
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 10:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgANJbZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 04:31:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40399 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANJbZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 04:31:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so12831835wmi.5;
        Tue, 14 Jan 2020 01:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QU2E8oF5JNAbYAlglR/3BSATG0M/9oeZpEn5cOfx658=;
        b=dTbjrvDYZFckqKtBKudHY/wanT9oRcRmu4cjV/a682HzEzAyq/phigDGXrIGdRNAWX
         Xmj65hrbyMh88uIlkVYCJ9C0bWzzjqOXF3T1fAeHlTIyvTgSt9our1d8v+FIPYRavm44
         taCE3FK0oQe65Rmyivv4y0S6Bq7N8CK10H79Uz6JFa1imu6cf3fpE7uDq/RBCmWHUxj7
         vWK3n++WEKeCWbufBHhlwlAbKdcZ3ax89Eo6Xb4LUPA1FWcaUVs3KC28/OJCZIrY+tIW
         H69aRpDOImg+Dtyzh6fGcL68gdrk5lRPsdLdcPFx1uN9kqpFgAWWYmbkIJoepEKIoogW
         NXpw==
X-Gm-Message-State: APjAAAVSPTJ8GyAWIICK6MDLGafPARBDjPup5sv0WpALUaUmbI3bTZRW
        vm1ZAmlp3tJb0+MYjICx5lw=
X-Google-Smtp-Source: APXvYqyHQjRYFKVsyb9fpuM9++YKCCEEOy55sI8xBmbf3cq9wfSBTTHMHKmx0zsXhNHLCf2m37p1ww==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr26849300wmb.137.1578994283622;
        Tue, 14 Jan 2020 01:31:23 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id e16sm18915745wrs.73.2020.01.14.01.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 01:31:22 -0800 (PST)
Date:   Tue, 14 Jan 2020 10:31:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, alexander.duyck@gmail.com,
        rientjes@google.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200114093122.GH19428@dhcp22.suse.cz>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
 <20200111000352.efy6krudecpshezh@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200111000352.efy6krudecpshezh@box>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 11-01-20 03:03:52, Kirill A. Shutemov wrote:
> On Thu, Jan 09, 2020 at 10:30:54PM +0800, Wei Yang wrote:
> > As all the other places, we grab the lock before manipulate the defer list.
> > Current implementation may face a race condition.
> > 
> > For example, the potential race would be:
> > 
> >     CPU1                      CPU2
> >     mem_cgroup_move_account   split_huge_page_to_list
> >       !list_empty
> >                                 lock
> >                                 !list_empty
> >                                 list_del
> >                                 unlock
> >       lock
> >       # !list_empty might not hold anymore
> >       list_del_init
> >       unlock
> 
> I don't think this particular race is possible. Both parties take page
> lock before messing with deferred queue, but anytway:
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

I am confused, if the above race is not possible then what would be a
real race? We really do not want to have a patch with a misleading
changelog, do we?
-- 
Michal Hocko
SUSE Labs
