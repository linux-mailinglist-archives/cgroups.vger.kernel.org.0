Return-Path: <cgroups+bounces-3635-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5B892EF44
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 20:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DFC1F234D1
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 18:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9016EB40;
	Thu, 11 Jul 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md30t4w4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94D161939;
	Thu, 11 Jul 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724360; cv=none; b=kVu6KGDg5VxXwSdNCiriHbL5h7u7mQZ8vICtOSRCIGZuqYZ/6MKvo2MD3jS5DbBp15ncKZK0pOlL+nRrWH4l/puCv5oWLCvp0N0v2lN4yf2C2Q5XR22cYy7KH/mJphfSzj+sWItQjUJb4cU2cgm4Oagz4W5ITBPyFwEL/Vlo/yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724360; c=relaxed/simple;
	bh=UdguaAOSauFRiLzQp7YnrXVJzMCTkUQF9aOc83nB8fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb/3qwzb8f5zn6qughU66YRcu1f+zjkmfm9OXHSYN2laIOhg9lCvfQzzCW2+EiTnRlOpXTok3J0sSpBKjazFHpDOi8aHnkRs7iSN8BT3cjSUFchQpuakoLd7cSqIO2k/Pg9pj1fafTh+9DQlJPqSG7Gtm3GzTnHwrpr1lv5RERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md30t4w4; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-70b2421471aso838144a12.0;
        Thu, 11 Jul 2024 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720724359; x=1721329159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAwJOLFxUKa89FAigcoASIJTkbTM7IYYEPI8ZeQQfr4=;
        b=Md30t4w4QdgBzY039RdVNHeKySocVwPxwzh0myZPzQFp43AuKte27zaiEUgp1Pvp8o
         Z6OgnMc/RmTTgUdRBvqmITP4uEJjJZnJ2S84+98xlbif1R0DbBkrM4Wg/1VE53sfKR2E
         ZjipEjXRF9N5siEY2qg9A2Lovg1Ovvx4fMgEr+2p/xA5HIO9F1xA19hKpHyVNEjJE7zJ
         LGiF9DPkAl9Y50U1YH9uHmhIwy2pzn6MnnjryYZUOpo9v5jfWeSP0gLxXt65251tgr6t
         0O6YT68dzCE5I9Nj+VEP2YlkVDCkLlMtdjxkp3MWJXUMx/hhultsWpEFidjCpkjgalbw
         aK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720724359; x=1721329159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAwJOLFxUKa89FAigcoASIJTkbTM7IYYEPI8ZeQQfr4=;
        b=E++U9Uuy+/CneXCq1SL6vcMZX/D9Ws28OMJiW1pGIuSTMzIpNEIWpqMkkNd6pwGUEc
         nOHR13k4wbXOhIxRagFUfzkefnutuevA9Yk0KJ4Bdbro9eWc4iNoS0h/lVceUJiqYYs7
         EwPuvXBkx/YOCidB6i5AsBCLYtwdiFwhXDV5tAhTkUiIw9V5iH6AqvSZ04qxPf+auFX6
         LriXWVMtJsgnmiuN8L8TuJhnqsxJ4eLAuAM85OInHXrPqDLbsS/OlZx0tVQm7C0rKEDR
         aZmsSKcAg1M5h9otivqwovXU9s7HBSfoTQrX9ebx+eb0OniA85XJtj4lRCSTb//SQBnX
         tm1A==
X-Forwarded-Encrypted: i=1; AJvYcCXh1h1FkCXJtiUJ8/LluaMuBdPF89NiNZda+dsXjdSKMtT6wNF1iZSWFtmqFvKb+RnUBiEVCIw8H2QDMuYHc/WYfYRHLMM3A+dd5aYXhO260nAJlEIPX/DhEPoZ3m7RDLfrxw5iKAc9A8cuPhKTuU458SQXHjBD++ebB8NspKvu1Q==
X-Gm-Message-State: AOJu0Yww9zkwpQAEWpIky69LtX5EzIFt/9ZOL3kBdAx6YWU7xnukwgrs
	pbxj/iYXFXO3G4yMvDb1TmBXS37i4PbyVz3+awCbW9sN3bjdTGd4
X-Google-Smtp-Source: AGHT+IEaYZysFDr3u4TvfrN/2rI5XMfoEv2tJeStwbblXJH7peMkHGNb5Ktf37hygbsa/aaUPqKrcQ==
X-Received: by 2002:a05:6a20:6a10:b0:1c2:94ad:1c6a with SMTP id adf61e73a8af0-1c29824f1dcmr12400776637.37.1720724358676;
        Thu, 11 Jul 2024 11:59:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b54ea2279sm3635520b3a.171.2024.07.11.11.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 11:59:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 08:59:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
Message-ID: <ZpArhD49OonR6Oz6@slm.duckdns.org>
References: <20240710182353.2312025-1-longman@redhat.com>
 <20240711134927.GB456706@cmpxchg.org>
 <4e1078d6-6970-4eea-8f73-56a3815794b5@redhat.com>
 <ZpAT_xu0oXjQsKM7@slm.duckdns.org>
 <76e70789-986a-44c2-bfdc-d636f425e5ae@redhat.com>
 <ZpAoD7_o8bf6yVGr@slm.duckdns.org>
 <e5348a85-22eb-48a6-876d-3180de5c7171@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5348a85-22eb-48a6-876d-3180de5c7171@redhat.com>

On Thu, Jul 11, 2024 at 02:51:38PM -0400, Waiman Long wrote:
> 
> On 7/11/24 14:44, Tejun Heo wrote:
> > Hello,
> > 
> > On Thu, Jul 11, 2024 at 01:39:38PM -0400, Waiman Long wrote:
> > > On 7/11/24 13:18, Tejun Heo wrote:
> > ...
> > > Currently, I use the for_each_css() macro for iteration. If you mean
> > > displaying all the possible cgroup subsystems even if they are not enabled
> > > for the current cgroup, I will have to manually do the iteration.
> > Just wrapping it with for_each_subsys() should do, no? for_each_css() won't
> > iterate anything if css doesn't exist for the cgroup.
> 
> OK, I wasn't sure if you were asking to list all the possible cgroup v2
> cgroup subsystems even if they weren't enabled in the current cgroup.
> Apparently, that is the case. I prefer it that way too.

Yeah, I think listing all is better. If the list corresponded directly to
cgroup.controllers, it may make sense to only show enabled ones but we can
have dying ones and implicitly enabled memory and so on, so I think it'd be
cleaner to just list them all.

Thanks.

-- 
tejun

