Return-Path: <cgroups+bounces-7653-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CF0A94179
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 05:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 287827B2EA5
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 03:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732684D599;
	Sat, 19 Apr 2025 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lHSPqzJ8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E374C85
	for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745034458; cv=none; b=ato9YD5cHfskD5zDuAHwUvIfwNen6EIxWvqtjZxyuNmB/X0WvUlcwyedb3EcsfJPnt1E+jXYc0tRDTGJv+o78StaFUjq/0gPTLk0e80cyXXxV5Qo6+gtB8VZYtoJHNRx3E1Hb1ygpUtcxYm/rFKwlEMUKDXse1+9IH0PD9Y8Zq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745034458; c=relaxed/simple;
	bh=bDGf7ax5uP145Z/QywUJDacWIi6TfWyn1aWA58lT7uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBBED6UIH/R8uT3GoHVl+dfa5wCGihutPSwU3r4RsIcRnrLfYQdsQwMVQRjZ3+CX8yJXMku7/fXdlDV0JnZdR0GzaLiX1cSYb2Wbq26S45q8l0eq4XbQjmvB/CoIPfIcZaroOvhjGmawp/UFhEQQt8i7euLVMuGX5O8MBdBwA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lHSPqzJ8; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c07cd527e4so230596485a.3
        for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 20:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745034455; x=1745639255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGkr4hYBihWGh7JmZ8GOd7BMmZ2Z6d/IyfdB5vi5hx4=;
        b=lHSPqzJ8gu/CYWVc6WvFFgDSRUE7tIs3dSF7guM+aO0BubMIjvkrY+PqR4YCeDdrLK
         U/uKmfw9ytzv89LuGk/3zMmWqSAuDlE69jDCisZ6zpepI45y5x8Ios97GOWfQsP+ddp6
         Q34NupwdEWIQ4435jbM7SZ6+nrElvstuaRn+cr7idflh55Lr8IfFGpPSB+zW+Qpvp1ZN
         gLuIW6aCuYU3yz2LVgjD6kGf/th5YqU5+y4SWFKLIv2A+cYQLHXRu7gegc4OiEK3vtYb
         D1HG7eBo9BkH7cCOUohqp3ylnFc2ULpqaPey5X9GQxDGqtIBcjS86/BwIVs3daY6Wo8M
         r0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745034455; x=1745639255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGkr4hYBihWGh7JmZ8GOd7BMmZ2Z6d/IyfdB5vi5hx4=;
        b=V3Y85fdzpTbvgNZxHeQSL2lp6kymeamYI4ixImXlsnsCBPNPD6Xaz9vdvGnjOgzvID
         6hrJLGHTOmoCsWH+mab7rFc/PW/qNDzcCOaBigDwdQoS62FjcIkUC39f+j8vjIFuokIE
         Y0jW7dpGfC02HvLemngvKhR00q3fK+g1ws5yz8xiejY+8m+aYWapmkwAjankE4HyFXZX
         KqLh/aurkiZCpduAXzE240KPbDJxH/kcro2gITUi2DmMut+TTKCyq7Ev56F/la4zg4X6
         aDkhVtmbx1Zy2oCZnhnanQU7YWE+mDxc2JPX882z7u9ieFpzE80qmRLtwNKKYSp9clI2
         M6ow==
X-Gm-Message-State: AOJu0YzVzeoERbeiACSoVFim4PsCdpnkVnZgQI7oP/WFixv8WnQJKcBI
	41xhdT5HCo7phYb0b8mhy2BOAV96h3yDWq+1zm0YxEXRUF13PKVkQbJ3Tm+j8IU=
X-Gm-Gg: ASbGnct3zvIZX+8PsxPKEYLtOpIg567pGnKutsrbwrDwdH+45tFjpKnhC9UA6kOlzwQ
	w0u9agRVbia58QKyu+JbpAEhwFCQsCRrtOkO1LXr54n4e4DKJC+w3AxFlnACYXvqQ1Ua2EMqya7
	Ox2rV+47r7kNQkZF7sOZoFkz0zp4mce/bb5noAL2j95nQxu4SiA6cD6FmVW+DFSGCQAY/5obW9E
	4qIPiImOowV3qFV1NNZElM9YiL84JmwO4mfeTnOEx/JwOgUx4APO5oURj/KPT+W7PBdFSq+oBCt
	fQfb5of1T6ctKEQOancG4ZBqfbcStTkmknswER5IqOI6WBHrVUVG+dD63eAyt3A8Wnblmp93Km4
	ZDxy/VppNeWT1f6lUZyxXy5o=
X-Google-Smtp-Source: AGHT+IHLpDeJmAWC8vn48omh/WZzD3TF09eoVh++JIk/Dh5S1v8tWk78RgXlZgP26pjlrMn9VABJOg==
X-Received: by 2002:a05:620a:4413:b0:7c0:be39:1a34 with SMTP id af79cd13be357-7c928038eb8mr806824685a.43.1745034455556;
        Fri, 18 Apr 2025 20:47:35 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6ee74sm177409985a.1.2025.04.18.20.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 20:47:32 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:47:30 -0400
From: Gregory Price <gourry@gourry.net>
To: Waiman Long <llong@redhat.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <aAMc0ux6_jEhEskd@gourry-fedora-PF4VCD3F>
References: <20250418031352.1277966-1-gourry@gourry.net>
 <20250418031352.1277966-2-gourry@gourry.net>
 <162f1ae4-2adf-4133-8de4-20f240e5469e@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162f1ae4-2adf-4133-8de4-20f240e5469e@redhat.com>

On Fri, Apr 18, 2025 at 10:06:40PM -0400, Waiman Long wrote:
> > +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > +{
> > +	struct cgroup_subsys_state *css;
> > +	unsigned long flags;
> > +	struct cpuset *cs;
> > +	bool allowed;
> > +
> > +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> > +	if (!css)
> > +		return true;
> > +
> > +	cs = container_of(css, struct cpuset, css);
> > +	spin_lock_irqsave(&callback_lock, flags);
> > +	/* At least one parent must have a valid node list */
> > +	while (nodes_empty(cs->effective_mems))
> > +		cs = parent_cs(cs);
> 
> For cgroup v2, effective_mems should always be set and walking up the tree
> isn't necessary. For v1, it can be empty, but memory cgroup and cpuset are
> unlikely in the same hierarchy.
> 

Hm, do i need different paths here for v1 vs v2 then?  Or is it
sufficient to simply return true if effective_mems is empty (which
implies v1)?

Thanks,
~Gregory

