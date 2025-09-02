Return-Path: <cgroups+bounces-9615-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71791B3FD91
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 13:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2E32C2CBB
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 11:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A14285049;
	Tue,  2 Sep 2025 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TG1LNgkq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD22765C1
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811837; cv=none; b=GtqihNosERTUVI4aCeWUPmTkQb79uPZk/yvsyvqdIKNZFsXonluuwFU6FXB6dNnLgT/dBVrTz0knBhvY3PjbM2vmc/Kz0KHwHANaEs18FKJC5YwKHlVUq5ys8/n8U5QYDp75KokHbO88CZnUeV2oBBLvo+8VLzQpp8jj5K91eUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811837; c=relaxed/simple;
	bh=tFz8mxWmtvp+OLRSVyZYdPXZ40EOLiMevSfJIuTSZIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsY1YinOZFgnlf92ep7a35n/oRVr7WWoWY7eDN7zhoi6qQRiuZrYNFpbroH1zcxbH4j2rO9rfc+CktL5ZoIeFo5ZyyMeaWqb2sJJ1NbuNCjwxooP9Hc+AwakpaELxhhPe/pTmToCqBWPZ58ChhzeTma/iso1kJ6usqkPZVtXD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TG1LNgkq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso1736509f8f.0
        for <cgroups@vger.kernel.org>; Tue, 02 Sep 2025 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756811834; x=1757416634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkjdJ99tSVQ09kKrtq0hv3IjTswl5kKM4uWkHH+xt00=;
        b=TG1LNgkqLtq9cIfMg2TppFSf7wDvWXZURS7bUn1zsAXXeR3nyDMz/jckkqyHVzGlj2
         EpJh0wN5eHePSXUV65F2EidnCCVvx7fofkNmL+j1uvsxbLWNXvz0NO6TDjBNB7QVAN6m
         y/9vDaHTAWhBLHOXcqEfg6DN0rle7qcoOMpi4wouoGT9Z+O8S+akwPqQxDsaZdC9+Dkj
         Hl37AkSXcMqFFZw5jSm2XiaDsPFdkUblK1haJtxCr4SA41/XEXeNihBa72aplEgySu0x
         dK42F8wLBJQ7zI7IArBWsUBq5d2csaCvesL5/GmrIA9SiKis+wpqFamZxMNpuuij/wQ6
         pgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756811834; x=1757416634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkjdJ99tSVQ09kKrtq0hv3IjTswl5kKM4uWkHH+xt00=;
        b=leD2JoAHVpJnT8ADpI7+ay96Y2a8nzE2XOX+Xuhj0MCR3/uuVfbwpZddtz9VY94WFv
         IIsMQ5YZ6UjXkrAOTUD1RcJUYznEFcKHLV7xJV3vnPjlq2w0ycuTX4PIYjj6jM1UyqF5
         ZK/rQ6/i4SRjt3jUReHzP4EEU+hRwaeuqX3m0BwQmwjpaS+AW3M0XvagL//01ovAoeSO
         TkgL9cY7IJmyLO16oEgkdyd2TGT6tQiehzyoVQSGC9WWJxIp54FdW2zq1jm56dPud9FU
         gJ8+rKdNGtU3pLFWnQC0M+EffMQ2AY3gR4wkIW7yVBj7/4AF0461tnkw/tpdmCJZARks
         9vqw==
X-Forwarded-Encrypted: i=1; AJvYcCVlqbwBotGFP+qWyo54pJuTuEjibQsgmmYaVhbvl0xyrebyHSiI/39l/2VL9ipcyWKM3h/mScOg@vger.kernel.org
X-Gm-Message-State: AOJu0YyjXNpdH3Q9XAjASB+qQwwSBEJAKjpma5kuyOmgTlKgRh4ptj4O
	qAAmeHwuSyAqMTDFTWf/E5BN4dAv9jwjA2flnxqB3CM77G5V6tokS8h6XknBBWSRtio=
X-Gm-Gg: ASbGncsoK2NuO9LsWLJfmOtffScfhA7IpwV0mSV6jq2kPJ2SPi6g9bvqf+4xlguE5RW
	fl62alKlN8tbumISoVPQjFn1qG2ivJgxCX6BdzDEiQ+9EyOGOZVyMwkRoQRUcqjzQEaTtwqDT9x
	2Nw6X/evqvxJKoMX7Qv94W2ACyjIDM2pjuHulQKDU5C4rFHKV17BSARfWole7s68NFZE2Bo3zEp
	F3zwGIgXirbhG3lAJV6iT7y2hyR3y5dueJyqTr1KQQz2aax9/Ya5VWjBhNokRBlFrCObft2YxGW
	Hikl/eUG3TYl+OetiDQx2oF63Xk5/rPuGqbF7P5QMZCX7vr1FM9hgIXKH4RNeyr2nuglfmlKSXH
	PUF3o9wc1Coaxj96SiGnhRs6YhbYTmR5UNNtQLMXJBrM=
X-Google-Smtp-Source: AGHT+IHz6YILuOaZ0SJzkFmlUROnxTGIZnMil2cOBLxZw94mqhQOg5dIe1n/6BlQbAypfFTe3xtbTw==
X-Received: by 2002:a05:6000:1ac8:b0:3cd:5405:16e7 with SMTP id ffacd0b85a97d-3d1de4bc31dmr8130862f8f.29.1756811834120;
        Tue, 02 Sep 2025 04:17:14 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e68c83asm207225375e9.20.2025.09.02.04.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:17:13 -0700 (PDT)
Date: Tue, 2 Sep 2025 13:17:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Message-ID: <tl6b6chfawtykzrxlmysn6ev7mq7gm764rnlsag7pfme7vhpof@lbwqooaybqmr>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
 <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
 <y7nqc4bwovxmef3r6kd62t45w3xwi2ikxfmjmi2zxhkweezjbi@ytenccffmgql>
 <92912540-23d2-4b18-9002-bac962682caf@embeddedor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jme3b5n5ad5ko2pk"
Content-Disposition: inline
In-Reply-To: <92912540-23d2-4b18-9002-bac962682caf@embeddedor.com>


--jme3b5n5ad5ko2pk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 09:56:34AM +0200, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> If the increase in size is not a problem, then something like this
> works fine (unless there is a problem with moving those two members
> at the end of cgroup_root?):

Please don't forget to tackle cgroup_root allocators. IIUC, this move
towards the end shifts the burden to them.

There's only the rcu_head we care about.

(You seem to be well versed with flex arrays, I was wondering if
something like this could be rearranged to make it work (assuming the
union is at the end of its containers):

	union {
		struct cgroup *ancestors[];
		struct {
			struct cgroup *_root_ancestor;
			struct cgroup *_low_ancestors[];
		};
	};
)

Thanks,
Michal

--jme3b5n5ad5ko2pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLbSLRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiIAwD/b00l+aVBPRUgP1zHehty
uF0kty/XKqKmicCz61ldtxcA/1riA1X/290Fr8aUbMO/YyrMIhkgpxSWHh+JPrSl
/WQC
=0maq
-----END PGP SIGNATURE-----

--jme3b5n5ad5ko2pk--

