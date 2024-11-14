Return-Path: <cgroups+bounces-5554-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFAD9C8C12
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 14:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824F8285A59
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3499E1CD0C;
	Thu, 14 Nov 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AfNzjjun"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E917C8B
	for <cgroups@vger.kernel.org>; Thu, 14 Nov 2024 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592102; cv=none; b=IsSDdLLYm5fP20akh5E3kH33GACZS/FrL03dgankwWpqmmxx/dIdx/Xtuhikh955siMTriQCC89+ithLnM9XhdTSj5c/8CVBoKky5BX2jui/IqkE5EZgLkvlu04JRaEB4+eJc+Zd0W8brcfe3LGPnEqJGaL6xMsyxlYFuT3Bk2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592102; c=relaxed/simple;
	bh=T1a/sDkY/OlZnEgzsaEHTLSkecp3oZdp43NwdguyHyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vt9xj15Q2Kd+lF+/AxWr+1EZmG8GXOt6ow6EYpkAfN0ki1qoYNDyTbt8OHLHwVObHDHjK0fi/q4qkVKwffI3BbzATfyf8s2I08fTtkXBn7mu3InDzjqCS1QPy4tGXWG8lzZjfyQlKVmqPW8XaXK1tYCpqoN0KaEQtUDbpmADH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AfNzjjun; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431688d5127so5724505e9.0
        for <cgroups@vger.kernel.org>; Thu, 14 Nov 2024 05:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731592098; x=1732196898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3iI6z7EX5qN/uT2xeFCyBltkCm8ugpopxlLsbix8AQ=;
        b=AfNzjjunscM9xI/O8s8KynORPfVe2kjXTdrYdxiMZin9L0ixnU0NlDC7ahPBBv7ALV
         VRR00hPjCpv1O+1LK1+AeYV1/oiE9RUhvJ7aQZEF6kXVPQdKjoeAEwk2gHo6BcjG8bcX
         ASsJreIT8rYyw2Hy0Z3bXBB4al4CnPNJAvW/av0KuySsl8KY0jEuihjIYQo3xD3JCvbP
         qXSo5AkO/7XNq1qO7hIkrKioXOq7/TzbCElTdQvLLc+s8Hhys8UDjgQj3RtkWvZfg08t
         yeA44JecAsj3gBvXnJZGQzh4wnC1JUAyFN+ApbDxoF7hV9AD3ZIwtTH3m+khTeq7Iawp
         UVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731592098; x=1732196898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3iI6z7EX5qN/uT2xeFCyBltkCm8ugpopxlLsbix8AQ=;
        b=cB30jak1AFIcjQKGuEmbp91phbxy6M8Z7Bhy74QY1xF2tv/JbkcEnSdRjIQdDN5RY0
         wLzTEqvfZ0ulAk83pxCLoa55GH89GXYd/xPASGOnkCtNY55uAx1YRtKpXWELitOCePdm
         9InJ5BieBEscriIDtc61zUHR8X3bwTibF+lYh9clhzor4LiSSeWUxrzzJAXOK1zFA8Iv
         f1magwvI6qOb4QRcmo+T0qjpTczbZgl1gEmQKbi/1NL6wjny6e2g1OH4AWNDHQp4aF5J
         0AKjbc4o9AK/OaLfT5CX2T0ASNB65c8XvOW0UhsCRyurKqV1yp8zgnVNY12+nkW5AKk5
         pLaA==
X-Gm-Message-State: AOJu0YzGs0iBDc7d0P6xFWQXSe3UIoWVh2bCt0U0rrSereNedw5Nwc/f
	915A8aAXdLVH/yjBHLpjhCJHa8e1iDfBtTSgW1Cnrqyc/zYQsCG/DwHoI6/Wpd8=
X-Google-Smtp-Source: AGHT+IGGcMNBArGb2EFcueVweYqcCQ0hv1EJYIXaTlhXn/0KPQEWNTLNBE/sWmoFqVloVAnsZU0mbw==
X-Received: by 2002:a05:600c:1d09:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-432b74fde24mr196893505e9.6.1731592098311;
        Thu, 14 Nov 2024 05:48:18 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da29ffe9sm24750375e9.44.2024.11.14.05.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 05:48:17 -0800 (PST)
Date: Thu, 14 Nov 2024 14:48:16 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hillf Danton <hdanton@sina.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Marco Elver <elver@google.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, tglx@linutronix.de
Subject: Re: [PATCH v2 1/2] kernfs: Make it possible to use RCU for
 kernfs_node::name lookup.
Message-ID: <u7h5zfjxz7yo6e2ukrlnznj4ug66pgu2cel4jqejjji4lzphv7@2b4ntlfl7q2g>
References: <20241112155713.269214-1-bigeasy@linutronix.de>
 <20241112155713.269214-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ibhqnvx46ox4edy"
Content-Disposition: inline
In-Reply-To: <20241112155713.269214-2-bigeasy@linutronix.de>


--2ibhqnvx46ox4edy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2024 at 04:52:38PM GMT, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -147,6 +147,11 @@ enum kernfs_root_flag {
>  	 * Support user xattrs to be written to nodes rooted at this root.
>  	 */
>  	KERNFS_ROOT_SUPPORT_USER_XATTR		= 0x0008,
> +
> +	/*
> +	 * Renames must not change the parent node.
> +	 */
> +	KERNFS_ROOT_SAME_PARENT			= 0x0010,

FTR, cgroup v2 doesn't even define renames and the full rename
(different parent) is only used by resctrl filesystem AFAICS.
I'm only mentioning it in the case you wanted to replace the flag with
two different rename methods in kernfs_syscall_ops.

Thanks for fixing this locking situation in general,
Michal

--2ibhqnvx46ox4edy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZzX/kwAKCRAt3Wney77B
SXsGAP9mq6zo6fojmMK07y5xwOF6JXw+3vwNoZiAO+/IlcLbRgEAtC0Uf4cFzaN2
ws//a7MG0InXqAuDxBK8m5y9HR5Tjw8=
=5SdX
-----END PGP SIGNATURE-----

--2ibhqnvx46ox4edy--

