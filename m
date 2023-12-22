Return-Path: <cgroups+bounces-993-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F2181C27F
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 01:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA17128387E
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E056A41;
	Fri, 22 Dec 2023 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNcjM1pE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268BA23;
	Fri, 22 Dec 2023 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35fc5f0f9c0so5639375ab.0;
        Thu, 21 Dec 2023 16:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703206757; x=1703811557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVcecegkpcKWOfoP3TqRfCqH3BZgHO5QSokYLXJOZiw=;
        b=fNcjM1pEFh9L9r1ZTYuobn9TUlV0utIhiB8DBlueOMKgG0pw3XwVvjkKuU8Mu74XEQ
         ekRI7NPqjfU/GSQ5J1fMnEvNz8DpVVkaVt0ZZ1qIEqVVkBhlDd+JLakL3oegzixa4Fyn
         11HHeVW2tE539qVo4F4eEjh/C0QD2m4/4BWN0GYy5R94dTud94KFQ3y3m9M6D9/Q7MRm
         oC/uNwx92jBfXwDd14A/J+gNAeC2uEusfS0aucjlPDZcAt+eJj87DmBIKLTLTvntsDkE
         Y+yOXEECsjR3ezf6cd9TptIVqAPyOiSP4ji4dF7P89imhDEZynriU+Q3Ki4itYbQoigb
         iNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703206757; x=1703811557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVcecegkpcKWOfoP3TqRfCqH3BZgHO5QSokYLXJOZiw=;
        b=CBC00gvT5FD4QAUt6C13+igE5Rh/WN0jFlAaCvZDqfcFUX4H7CPOeET4vlCWRh9SJM
         fruAHknQUXsApmtyKyah5EjAIxhOoQwVE/aT2i3OenzDGt7xLCrciKCx2T+hgVu3cBrz
         eFJIYxgzxvHFDzC3wVQfr2s0X6AMVo/MsSZwjfu18+bqEnR3L5f5I3c/Wn32N6XAovDp
         jlEVwDRiJR3HvR3t6d9ShGIJKxWG+Vq+HE84Px3JR12Nm7IidIoQ8tJWGYc5xy8AbnjL
         AjjTHnlkZ9D36nHW0G6ns5bUfsna66bDQJ9xYhQNKu3ddTe33rqaL3GDWgDSVd5OuF9G
         L/WA==
X-Gm-Message-State: AOJu0Yx6EwrXE2xlqphK1SAdwcVkNeKfKzIAYV2qtLi4ohHLRAD96vjx
	ZYVXPQNsGSc2K7EIzRjU1uM=
X-Google-Smtp-Source: AGHT+IHbLLqmX5WkgqGut71nma2X6yTuFUNCa9AIFD6v7jRqD9xSq9whQAQ1efU8W6qTvCSQDgQ56w==
X-Received: by 2002:a05:6e02:3489:b0:35f:c4c5:91e8 with SMTP id bp9-20020a056e02348900b0035fc4c591e8mr716996ilb.60.1703206756743;
        Thu, 21 Dec 2023 16:59:16 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b001d3e9937d92sm2306646pla.51.2023.12.21.16.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 16:59:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Dec 2023 09:59:12 +0900
From: Tejun Heo <tj@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/3] kernfs: Convert kernfs_name_locked() from
 strlcpy() to strscpy()
Message-ID: <ZYTfYAHZHpD9ZSnE@mtj.duckdns.org>
References: <20231212211606.make.155-kees@kernel.org>
 <20231212211741.164376-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212211741.164376-2-keescook@chromium.org>

On Tue, Dec 12, 2023 at 01:17:39PM -0800, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> Nothing actually checks the return value coming from kernfs_name_locked(),
> so this has no impact on error paths. The caller hierarchy is:
> 
> kernfs_name_locked()
>         kernfs_name()
>                 pr_cont_kernfs_name()
>                         return value ignored
>                 cgroup_name()
>                         current_css_set_cg_links_read()
>                                 return value ignored
>                         print_page_owner_memcg()
>                                 return value ignored
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
> Link: https://github.com/KSPP/linux/issues/89 [2]
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
> Link: https://lore.kernel.org/r/20231116192127.1558276-2-keescook@chromium.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

