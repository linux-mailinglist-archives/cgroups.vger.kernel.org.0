Return-Path: <cgroups+bounces-3639-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD4B92F00A
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 22:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57B91F2437D
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 19:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4867B19E832;
	Thu, 11 Jul 2024 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="wl3eW6oG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6E450FA
	for <cgroups@vger.kernel.org>; Thu, 11 Jul 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727995; cv=none; b=SaBP8QLqOaFBhlhdxW7Sr8nok5ZDWyLNgxsf7E5TVTp+kdGNFagvgJtFRI09YmSdLuf3qdK98/QRwBKCTeCVbh/Dii6CTqvkclKQIRPotvKQ1LnrSxIVeEtfFsGtq3P/+hCYRR3crLHJIUI/NYCi6yU32hyh7qmJW4GDsJMOoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727995; c=relaxed/simple;
	bh=ZFsNRA4oHonDs7htq9TQlbzH95+/U/2f1q+48RdjPCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcxGmm9Nj5bSTVUFMAPE83qZ/xbqplnMuQYbdEOBPXw6Lyw2XW6gw1AqvQ1kcMSvQawnE2X+Pae/WVlYntghw6ODKrSUhf+yYln7ztYnguwBmDE556elB+FHsAPvHw5KHh4zScLP+6JwIEhM8G+BU1Ebmp9LNrKWTunDVpQn5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=wl3eW6oG; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79f19f19070so70874585a.0
        for <cgroups@vger.kernel.org>; Thu, 11 Jul 2024 12:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1720727992; x=1721332792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0fBzMvARzNqWDIvjkNZtGgftU6BR00tv1V56A0sRI4=;
        b=wl3eW6oGF0nyU+9MJlx/LeYF/XzTYUj6S1aWCdB0+83FpI/C05K9KU3N7gccelZB6i
         cqfVDKbjEpp2n68Yn+gUexD5gvuB5s217Z7UpY9EQim/OgOXaqj4aqADEn1jto8p1Jod
         Gjk2PLHFksRK5an8e2ssA1u09X7dA8nyYt/dlVVXgmkbs1NPBXGqfDJq8JGCP7LZ+wC9
         QW9b+a7F4B0wMMo/0+fMPiS3tRFxfKp8zH7a9Bmhtp+4Cho8xuLuCbYCSF4ObP9TBXRg
         cmMYwWFdEA9qSbHeVerqdtL+3xPXuna7tnla45fiwNPCF3W4ELO4sorjN2YMhJyTTvNe
         8cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720727992; x=1721332792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0fBzMvARzNqWDIvjkNZtGgftU6BR00tv1V56A0sRI4=;
        b=fFOpFKBaAjb9RV3sU+RqJBNglRL9gO+Fc1GzPSUx1wN/1awJ18lpGCeQg6mcu2xJIu
         ImWC7nK7vziFi3yqQdJDcbnRKsGOH1VWstLrDIdBq+eDSrWK+XGixmTaWitdgUsG9+EN
         3PLykIKZ41X8q0wSn1RJjopqz22PEZrrC7xGcfWnG2I91JO9k3pef260BkWD7FQWskaQ
         9CSfCPg4+YFlq9A9vNdiT3ECHqbrEB5EPIfgQJVfH/ZzYiqBRJinGP/F86CAqknlefZ8
         EFbiHqoyCI9UrP+bHRaTf5wNM4GacOvGAHx92zKXeicAilO0BkRmb+Uk4ecBVVyFE5ed
         Zk4g==
X-Forwarded-Encrypted: i=1; AJvYcCWucKrl+hAZ+q4cO1MACSBProd3YJLBoNc/+G1ipepjNu6XLs4nf4hltPmfeKnTSTI+Wj89i1IDGLPvIGRPS7NnrDMH8bh9vw==
X-Gm-Message-State: AOJu0YxHoDSHyFiBah6SIGINQglJwCVC8hHkfE5RFYC3swIQBfeVgon/
	it6S2M5YtGJdMSzuXjlOYuwtZ+F8RzhM4hkbmEamu5FjtqJdiFrqDEd+mMbzjJU=
X-Google-Smtp-Source: AGHT+IFiJnY/cGELlDLmvJpmQlnosRF0R2F/8VoRGVECBWJ/JmxJND9XjYQhP4M0tiwANXIyAJJhqw==
X-Received: by 2002:a05:6214:c2f:b0:6b0:71c0:cbaa with SMTP id 6a1803df08f44-6b61bf1b857mr113709506d6.33.1720727991788;
        Thu, 11 Jul 2024 12:59:51 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c4867sm28611176d6.26.2024.07.11.12.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 12:59:51 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:59:46 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
Message-ID: <20240711195946.GA1094169@cmpxchg.org>
References: <20240710182353.2312025-1-longman@redhat.com>
 <20240711134927.GB456706@cmpxchg.org>
 <4e1078d6-6970-4eea-8f73-56a3815794b5@redhat.com>
 <ZpAT_xu0oXjQsKM7@slm.duckdns.org>
 <76e70789-986a-44c2-bfdc-d636f425e5ae@redhat.com>
 <ZpAoD7_o8bf6yVGr@slm.duckdns.org>
 <e5348a85-22eb-48a6-876d-3180de5c7171@redhat.com>
 <ZpArhD49OonR6Oz6@slm.duckdns.org>
 <c54651db-1a06-49f6-aea7-02768ad70756@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54651db-1a06-49f6-aea7-02768ad70756@redhat.com>

On Thu, Jul 11, 2024 at 03:13:12PM -0400, Waiman Long wrote:
> 
> On 7/11/24 14:59, Tejun Heo wrote:
> > On Thu, Jul 11, 2024 at 02:51:38PM -0400, Waiman Long wrote:
> >> On 7/11/24 14:44, Tejun Heo wrote:
> >>> Hello,
> >>>
> >>> On Thu, Jul 11, 2024 at 01:39:38PM -0400, Waiman Long wrote:
> >>>> On 7/11/24 13:18, Tejun Heo wrote:
> >>> ...
> >>>> Currently, I use the for_each_css() macro for iteration. If you mean
> >>>> displaying all the possible cgroup subsystems even if they are not enabled
> >>>> for the current cgroup, I will have to manually do the iteration.
> >>> Just wrapping it with for_each_subsys() should do, no? for_each_css() won't
> >>> iterate anything if css doesn't exist for the cgroup.
> >> OK, I wasn't sure if you were asking to list all the possible cgroup v2
> >> cgroup subsystems even if they weren't enabled in the current cgroup.
> >> Apparently, that is the case. I prefer it that way too.
> > Yeah, I think listing all is better. If the list corresponded directly to
> > cgroup.controllers, it may make sense to only show enabled ones but we can
> > have dying ones and implicitly enabled memory and so on, so I think it'd be
> > cleaner to just list them all.
> 
> That will means cgroup subsystems that are seldomly used like rdma, misc 
> or even hugetlb will always be shown in all the cgroup.stat output. I 
> actually prefer just showing those that are enabled. As for dying memory 
> cgroups, they will only be shown in its online ancestors. We currently 
> don't know how many level down are each of the dying ones.

It seems odd to me to not show dead ones after a cgroup has disabled
the controller again. They still consume memory, after all, and so
continue to be property of that cgroup afterwards.

Instead of doing for_each_css(), would it make more sense to have

	struct cgroup {
		...
		int nr_dying_subsys[CGROUP_SUBSYS_COUNT];
		...
	}

and just always print them all, regardless of what is, or was,
enabled?

