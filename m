Return-Path: <cgroups+bounces-994-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC6D81C2A5
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 02:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBFC1C24795
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 01:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C04FA5D;
	Fri, 22 Dec 2023 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7vUQImb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13062A31;
	Fri, 22 Dec 2023 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3ef33e68dso10083135ad.1;
        Thu, 21 Dec 2023 17:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703207940; x=1703812740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5M5AxMMQu0Viq3UcUmDsSmKqUHU9MnY6HuEjJ5YQdCY=;
        b=R7vUQImbLUycPg6GsBRj317EkEtroZV+zuh4uFyFuFuTWjvlyLrT4aT5zjT1YMKLk2
         64cvH4w9PjLIFlsLiegiNf/zo83iJ7vljxl1ADLJ+Rwk4AcZGrvrPU4BINmZOSV2DZK2
         /q3XYIwlmKfUi9ZW0Y/DNXhfTvaenSRlhBlrXB+Ri3+DemR73T8J1eldZ30oRa1wdN/J
         yhMbpxfFQRYRG2/KpKg0qFrebzbHfVQIRgHFBH91HL26zAxeqPOSIyi5XQg4i0joqbAk
         i+iVd5ShUIe2A8exhpf3QhHDr6tGzj3BdOu1MKXhoTogyO/GwmsbFbDjDRhNdNP5eSG5
         gHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703207940; x=1703812740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M5AxMMQu0Viq3UcUmDsSmKqUHU9MnY6HuEjJ5YQdCY=;
        b=NWzwcNxfcnc2PiXedSaFiRgoQXSzzlgwbJDYiTW8VckjjQHH+eZDFZwL/FSHCjJQKl
         tiEj5VvXG6cy/slgLQTq06jvlFSulr+rd9tnsRtd14Yr7UyVONz7jM9NFUgZ2rvElhbd
         Mut2MfsRuaFFG5t1FrWiF+N/2mk9X9xSFPIEbFfOA1mt/uQibJM2G5lB/q4we1ObsrUa
         nFVdHaMtRni8QS4lrlaYBKRn6RY81rB1p3c1ccCz5zX617ShdORk1DuTXYFDZP1O4XJX
         uorSsV2UCJ31n7UO/dOhr17KxtzWUoz0jvcpAcCgFMh1GsyY6n/7/kjutOK3nCcvmonT
         pBlA==
X-Gm-Message-State: AOJu0YwSEqTN7x6L04nHPEDAQoa4je8V3oc9apz5WkwPEj/gr2zCTDtZ
	kAdRW9oJg/Wn3N2TOcqFJno=
X-Google-Smtp-Source: AGHT+IHjrtiHpm/EyWpKjD6vMdthMirHzVcQzhGW9iiBKX/7IextBEWw66I9yaxLD+tYjd3p9XK4VA==
X-Received: by 2002:a17:903:228d:b0:1d3:ea4f:5e0f with SMTP id b13-20020a170903228d00b001d3ea4f5e0fmr758747plh.29.1703207940079;
        Thu, 21 Dec 2023 17:19:00 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902fe1800b001cf59ad964asm2266239plj.140.2023.12.21.17.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:18:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Dec 2023 10:18:57 +0900
From: Tejun Heo <tj@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 3/3] kernfs: Convert kernfs_path_from_node_locked()
 from strlcpy() to strscpy()
Message-ID: <ZYTkAV-CE3ZslR7U@mtj.duckdns.org>
References: <20231212211606.make.155-kees@kernel.org>
 <20231212211741.164376-3-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212211741.164376-3-keescook@chromium.org>

Hello,

On Tue, Dec 12, 2023 at 01:17:40PM -0800, Kees Cook wrote:
...
> @@ -127,7 +127,7 @@ static struct kernfs_node *kernfs_common_ancestor(struct kernfs_node *a,
>   *
>   * [3] when @kn_to is %NULL result will be "(null)"
>   *
> - * Return: the length of the full path.  If the full length is equal to or
> + * Return: the length of the constructed path.  If the path would have been
>   * greater than @buflen, @buf contains the truncated path with the trailing
>   * '\0'.  On error, -errno is returned.
>   */
...
>  	/* Calculate how many bytes we need for the rest */

We probably should drop this comment.

>  	for (i = depth_to - 1; i >= 0; i--) {
>  		for (kn = kn_to, j = 0; j < i; j++)
>  			kn = kn->parent;
> -		len += strlcpy(buf + len, "/",
> -			       len < buflen ? buflen - len : 0);
> -		len += strlcpy(buf + len, kn->name,
> -			       len < buflen ? buflen - len : 0);
> +
> +		len += scnprintf(buf + len, buflen - len, "/%s", kn->name);

scnprintf doesn't return -E2BIG on overflow, right? It just returns the
truncated length, so the overflow behavior would be different depending on
where this function overflows, right? Not a huge problem but it may be
better to keep calling strscpy to keep things consistent?

> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1893,7 +1893,7 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
>  	len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
>  	spin_unlock_irq(&css_set_lock);
>  
> -	if (len >= PATH_MAX)
> +	if (len == -E2BIG)
>  		len = -ERANGE;

I'd just pass up -E2BIG.

>  	else if (len > 0) {
>  		seq_escape(sf, buf, " \t\n\\");
> @@ -6301,7 +6301,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
>  		if (cgroup_on_dfl(cgrp) || !(tsk->flags & PF_EXITING)) {
>  			retval = cgroup_path_ns_locked(cgrp, buf, PATH_MAX,
>  						current->nsproxy->cgroup_ns);
> -			if (retval >= PATH_MAX)
> +			if (retval == -E2BIG)
>  				retval = -ENAMETOOLONG;

Ditto.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 615daaf87f1f..fb29158ae825 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4941,7 +4941,7 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>  	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>  				current->nsproxy->cgroup_ns);
>  	css_put(css);
> -	if (retval >= PATH_MAX)
> +	if (retval == -E2BIG)

Ditto.

Thanks.

-- 
tejun

