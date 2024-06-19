Return-Path: <cgroups+bounces-3240-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C5F90F528
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2024 19:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4867B232D0
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2024 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA30152170;
	Wed, 19 Jun 2024 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKzAu5DO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323155884;
	Wed, 19 Jun 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818431; cv=none; b=MTO70ui+DXD9p08lTf4F5iv1Z3FIbaGefrxL3oM/CCVv3LuiVvkc309JgAXbdiXQOpLfHhgh5lYBkk8eUmxvCJSBn8qratGrmWd/RO/5dBhB708qTKbvcIU74q+J5Kf8AcNEWfQ8/XFIJ7V7ezYiOz1aG5KibEKq6RDcyatVqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818431; c=relaxed/simple;
	bh=NhXQpP5JSuXGv4UOVeTcHcdCKwgq8YGXn/U1WzJL7Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X07bzERLFOu7Z7h/rrVKbHOeW8Se56XnJMHAzFrk/6QaAk9gtuCEEUeoyXoerYYqW4H/vvMwK59JXUKORycuVhA5BIgLBwuhJNwBhx4AgPisLetItUlZ+FFsimbP7z9NGC7fnzpx8nMwi1J+k9tuY89GCOIj+EOeX2OcQ86/50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKzAu5DO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7023b6d810bso57489b3a.3;
        Wed, 19 Jun 2024 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718818429; x=1719423229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MHYuCTXj1wgKr32ecevMwTNfCM7u5/w/vIeb4fObr0=;
        b=PKzAu5DOAksFaUCaeImrZyFQ+SNlxVovDQBQxtTAmhEQPAfJseb1niUz4vSs0/+eef
         8i3MdffhXRfc4ZcyNIfvVkSGZuy5ScNkgZOSWIrWYLvnS2w5YbFu5tSmGZqhJMGfcAuw
         OvHa65qYQq227Mrh+JlDXKSrzd5ogI1ATb+OOuRKT5WRE9m5b97IaR9Wgz03R26hhI2G
         D4k9kS3lmjXJksQt0/aui49/uhebntxLqqM2W+g+E9/UBCq/fOJrDDILQt6iIyf5Wfh1
         4lfcRpWSuffLKeHhqqUsnKM2qf6Y0Oc5dRNdrWviDRh5akkJJiRWrzZyCG7SYxuUiyql
         62RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718818429; x=1719423229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MHYuCTXj1wgKr32ecevMwTNfCM7u5/w/vIeb4fObr0=;
        b=JP0ZitK1+ec8kqPkR0Yp5LI3tkCo42TDRxL+zR2bomqGsKyxjxFpL8c09cMOoGaBHa
         Em8iTxO60o6ntaQ26Dnv4U5u/4sWBnoV+T+VCbYwQ2IMl56b1bobKRXrJ5NrFhbouXYm
         +7hrqdOY5d5MJK631KqwLPxm0uktKW3hHgwYS4FvyP37fAs5q1Va2pOQsl7eAN2B9nTh
         DPTNpcuIG+o8YimnNM1ul0KwmdfvsY3y8U6Mth/xqfVD1qfgALAUdgh+hoJngf0KXnt3
         Nu/FsZddcrrYHzx4230jCzsjkbb9CljiU5z+BhgMdVDOzMEdpC1fT1NapwyACu7eurk8
         JsrA==
X-Forwarded-Encrypted: i=1; AJvYcCXC9jUGmqVKisAhwci+y3Go5ZJ3Hyz5uyTYLMRNYhg0M+eSWKztaKKXLNisNZ0ZJust2wWDUvk0FouiTQY/CevsTuGISUkFUeqUTEECsk7n4VIO+h5ZVrjYUYyyd95VFJ9mLc9Y/w==
X-Gm-Message-State: AOJu0Yxqfj0xJtVFjgKLOBjgM2UllnqcJRy0ENrQOl04+F+6SqhP7ZNW
	yyTizMh9gQbXgt2r/AVvf2nYtSuay8UM0sgYa3gaMrj1bo69++bG
X-Google-Smtp-Source: AGHT+IEm8A83LuqziTExDgYEpe8+ENozNbQf8yOYX49jpolFcY3ZmW1xGtRUUhma91RUUxT6PB3dWQ==
X-Received: by 2002:a05:6a20:6386:b0:1b5:d194:d87f with SMTP id adf61e73a8af0-1bcbb63c664mr3134905637.59.1718818429033;
        Wed, 19 Jun 2024 10:33:49 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6c1c7sm10996557b3a.167.2024.06.19.10.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:33:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 19 Jun 2024 07:33:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cgroup: avoid the unnecessary list_add(dying_tasks)
 in cgroup_exit()
Message-ID: <ZnMWe4dcz3M6cyAU@slm.duckdns.org>
References: <20240617143129.GA10395@redhat.com>
 <20240617143152.GA10404@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617143152.GA10404@redhat.com>

On Mon, Jun 17, 2024 at 04:31:52PM +0200, Oleg Nesterov wrote:
> cgroup_exit() needs to do this only if the exiting task is a leader and it
> is not the last live thread.  The patch doesn't use delay_group_leader(),
> atomic_read(signal->live) matches the code css_task_iter_advance() more.
> 
> cgroup_release() can now check list_empty(task->cg_list) before it takes
> css_set_lock and calls ss_set_skip_task_iters().
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

