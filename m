Return-Path: <cgroups+bounces-744-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2316C7FFD36
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 22:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63F3B2103B
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D3255C12;
	Thu, 30 Nov 2023 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4iP/X4y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0820D1708
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 13:02:34 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cdfcef5f8aso66722b3a.3
        for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 13:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701378153; x=1701982953; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NyeHJWiLdFo7I9JRqXuJBHQL2k3baSzOcxFT8tS/iws=;
        b=c4iP/X4yHnygKgxRG6y3Jq0EuNnH+e/MjnLJkY+x+XbFSZ4uinvEAgkP9QmN32wXVI
         kcW19abkTTdXK8RsFxkg/YZVWv3Y2f9gnyIAxFnhcGD3SwtfhOlbLK6HnqVsG+yCA+A6
         Rs4452K4JBcfAAaIarZCQHHxUTADGZDAlq2U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701378153; x=1701982953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyeHJWiLdFo7I9JRqXuJBHQL2k3baSzOcxFT8tS/iws=;
        b=IKCwYK4Dwnt6w4kAEAXRnOe66XsjyasuqLjSwcvVA0wTzT8ff9fafeb9wDR/YWhbAg
         jxqY9P3OZWaAqsrUkZYYxB2FGMc6khGV93VphGaokZg6IuoEC1Lj3oJedce3OiEeg8YE
         Xv75/bKHGpzTPh1ww7FG6TDUWf1pnDmWfP0PJVMkhUpSPOYQk1BRZuPEPLgTj1NRhGq6
         8+Etbiso9LeGhK2GxnNvaR8NeZleLYth1rgin3uZ3C0oB+nBLnwLv6+a7JmH5RmJ/sBM
         IVK2SgPwVw/GEHw/a4MdL8CmOHrPPFGE5igkJIhm9/lJXE5IWgr48LUw3vJVyNxEK9uE
         ohwA==
X-Gm-Message-State: AOJu0Yzg2s6jgwJqrS7laGInb9wa7O3snwl3372hlNxGIlAONS5WyWOt
	qw+9rpmcjC+nljq07h9yfZkyuQ==
X-Google-Smtp-Source: AGHT+IFPqOtCQKaiIkfNERoPXQRP8a11ba8grcvFLj1169pKYiYb6nm2g+juLHikzSkTaUhFgcumtw==
X-Received: by 2002:a05:6a20:daa8:b0:18b:914a:a81 with SMTP id iy40-20020a056a20daa800b0018b914a0a81mr28046510pzb.52.1701378153297;
        Thu, 30 Nov 2023 13:02:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k187-20020a6324c4000000b005b7e803e672sm1726803pgk.5.2023.11.30.13.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:02:32 -0800 (PST)
Date: Thu, 30 Nov 2023 13:02:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] kernfs: Convert kernfs_path_from_node_locked()
 from strlcpy() to strscpy()
Message-ID: <202311301300.6BAB981@keescook>
References: <20231130200937.it.424-kees@kernel.org>
 <20231130201222.3613535-3-keescook@chromium.org>
 <40b65db9-1b37-45b6-8afe-7be2df11cfa9@wanadoo.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40b65db9-1b37-45b6-8afe-7be2df11cfa9@wanadoo.fr>

On Thu, Nov 30, 2023 at 09:38:11PM +0100, Christophe JAILLET wrote:
> Le 30/11/2023 à 21:12, Kees Cook a écrit :
> [...]
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 8c0e5442597e..183f353b3852 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> [...]
> > @@ -158,18 +159,22 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
> >   	buf[0] = '\0';
> > -	for (i = 0; i < depth_from; i++)
> > -		len += strlcpy(buf + len, parent_str,
> > -			       len < buflen ? buflen - len : 0);
> > +	for (i = 0; i < depth_from; i++) {
> > +		copied = strscpy(buf + len, parent_str, buflen - len);
> > +		if (copied < 0)
> > +			return copied;
> > +		len += copied;
> > +	}
> >   	/* Calculate how many bytes we need for the rest */
> >   	for (i = depth_to - 1; i >= 0; i--) {
> >   		for (kn = kn_to, j = 0; j < i; j++)
> >   			kn = kn->parent;
> > -		len += strlcpy(buf + len, "/",
> > -			       len < buflen ? buflen - len : 0);
> > -		len += strlcpy(buf + len, kn->name,
> > -			       len < buflen ? buflen - len : 0);
> > +
> > +		copied = scnprintf(buf + len, buflen - len, "/%s", kn->name);
> > +		if (copied < 0)
> 
> Can scnprintf() return <0 ?

Ah, yeah, it's can't at all[1]. I forgot! :) Honestly, that function
should return size_t, not int...

I will send a v3 with this adjusted, but I'll wait for more review...

Thanks!

-Kees

[1] https://docs.kernel.org/core-api/kernel-api.html#c.scnprintf

-- 
Kees Cook

