Return-Path: <cgroups+bounces-3415-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E4991AF14
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 20:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB081C21269
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 18:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B22199E93;
	Thu, 27 Jun 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjTfL1rB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA201CD31;
	Thu, 27 Jun 2024 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512977; cv=none; b=rdUVAklMEc+8UNamuONQzrVb/9M+ZOXtn6PuRmGjtm4NioGg1eDOADJ1i517UaJx7VsCAPTyHqWFjKeZ7UUeDXy1pNltOKlU854I3NPmnuNnvO1RY5ww4/Gq/mM0UI3fSfGNCsMUz6jO634c1/0mvFrZikeCdv1fTMu2BVx1FqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512977; c=relaxed/simple;
	bh=UeinNsSogViVvGqzhITgqEOSYskNo56zP0Jpdwu1fvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD16OzsxRbfLJBYbInv+mowjW/xP5R7W7dNZsXNSumus3xuYUo7qmmMQUAP3VPK0OJfWtI/wOmPai1e0GTGGp2lN5dBbGKTkCf0XXU1lrn2SnmCTOGw7fCyJYTr5Yeg7YlISM6V9HSnePzfFOzsixpYamEYBKiimI659mm/GPz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjTfL1rB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f70c457823so56473085ad.3;
        Thu, 27 Jun 2024 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719512975; x=1720117775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qmnH20jLkcRfLXx/pLmQ8XEHPgJX7ltggVePU1FY5k=;
        b=gjTfL1rBQYRMHwRqymROAxi8iStT1zdMJsTOQM/zRpevPDjD/BWzKVOqKcO6M6K6PI
         I08RuaoILbA9N63CkoEi/dK8naPSU8cvqdWpVCqiJSTd3+YRPGcHmsGehDf1+Be8ubgQ
         v1thUXkjOZfMWDKPBh9jPPBULl/sVzYWst4CqkXccbeTOGu6rr5sgsWJuxRGIiXN1eI8
         ThRiRfh7bTqY7baXy9uQcGzmh8M7VsaHqIVRhkml2htWoFJYuykstESAfltV4ZVAXci0
         tl0YcX1B+dOk5zVYCGu3wFfITzJY1jnT8lqocAqqir2yxj3iBLqn1ccO4O3DN32QUVHS
         nTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719512975; x=1720117775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qmnH20jLkcRfLXx/pLmQ8XEHPgJX7ltggVePU1FY5k=;
        b=B5BlLAD0IUWLwAzHcwZKJqyQwB+wEsbze21D9NksuRVNITInbSmFg0rnNNeEbc1bIE
         Or+5ftDvLMF1hLb0DItyxYFeJGVasS1tX/ze8ILiyCl/+5TIF7MjcIWA2kzRYrPUKZgH
         YMhlpm8sIr4Udy60FNPC7BP4WRnC+lPIqba9vLvVAW6teihNcwjBio+t+gnXbUnFO8aU
         rTXIukoFW4+iP8qSxkCZID4gudzQFubTqXx0DUCFfV4x5k+Kuq+akghFLscfccHXyV6j
         uupzBq8yhv+87GKN0PQ0iqPOJCKpEtHCWCk69DsoA37EBXjUWb3kCcYZzscsJuszy7K3
         6Aiw==
X-Forwarded-Encrypted: i=1; AJvYcCXcoLbU3O9GpWC8t004Izrdu198wh+KaSV6mqTjESwpS2FVt8fNIvXT0lyNun5O79FviKlB9ZUpRGnVEjgfpKlhC4QUNY0hLcIPiV9Vnt0z/cz7Vbuh8n22N4QHnfeolrMMi0KKyA==
X-Gm-Message-State: AOJu0YzinW+O0YckO1mTwmpaG4AP+GuK/t4yQWjhofwMNJAocZkkprau
	R/sxqGO/TgaR6QKhqs89tRCUYRqYLS6Dx2H+U8PVO565ts5Duepc
X-Google-Smtp-Source: AGHT+IGG8QjY7R6t0vtWLZ1JCKLW3yU2Pt0MVlDKczbaQlejp7rEaDDuNX+NlG/XEb2fSUMSGCy5Hg==
X-Received: by 2002:a17:902:eccb:b0:1f9:fbeb:f2bb with SMTP id d9443c01a7336-1fa23ee57d4mr146668555ad.35.1719512974916;
        Thu, 27 Jun 2024 11:29:34 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1569660sm639845ad.231.2024.06.27.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 11:29:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 27 Jun 2024 08:29:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huawei.com>, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, longman@redhat.com, adityakali@google.com,
	sergeh@kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
Message-ID: <Zn2vjVNnIcUN8lXM@slm.duckdns.org>
References: <20240626094101.472912-1-chenridong@huawei.com>
 <6mjie6enbm5ltei4fsanz64ofukbr4gvss7ywi5sjfjxjxing7@efuhtnqvfawd>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6mjie6enbm5ltei4fsanz64ofukbr4gvss7ywi5sjfjxjxing7@efuhtnqvfawd>

Hello,

On Thu, Jun 27, 2024 at 11:46:10AM +0200, Michal Koutný wrote:
> Your patch should work thanks to the rcu_read_lock and
> cgroup_free_root/kfree_rcu and the `if (css->cgroup)` guard is
> unnecessary.
> 
> So the patch is a functional fix, the reasoning in commit message is
> little off. Not sure if Tejun rebases his for-6.10-fixes (with a
> possible v4), full fixup commit for this may not be worthy.

This one's on the top. If Chen can send me a patch with updated description,
I will replace the patch.

Thanks.

-- 
tejun

