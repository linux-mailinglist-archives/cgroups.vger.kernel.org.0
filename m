Return-Path: <cgroups+bounces-6105-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC22A0B83E
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC1C1886B59
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E32343AE;
	Mon, 13 Jan 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HMBfWCgt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA0A22A4EF
	for <cgroups@vger.kernel.org>; Mon, 13 Jan 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775300; cv=none; b=q6zHqAQDWZcAkRAY0ME7N5k4IhFcFQVk7dVf82lFAhVop1jC9hOk55m4EBkwa25f019A7+FSE9ZA16wKwRIPmmV80gs4yZDshQ4TtGVMMLxvJOl2WN5s9O4o5cqUjC9Jp7Aq2ivgpbZi1jRoDX7ZiMABKsKNh9Ru2i2yllkBws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775300; c=relaxed/simple;
	bh=QjR8z4REehx/8ZFb4vUXNWl5v6Zuh5ZvzSywNBFAF9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny2C7QkcZPJ1mgwoRH9XT1as5V0E7yxIU+gDphO1Zdc6Q2dIbVq7P08VHf/SBn+YubH3J+7r7SldUbfYImY9ppyRcVficLIxI2pAdlpAYvdGAOgOPcPkhtUtXUV0t4IclNfP/7Ctc5mNc+5V4+GPruPg68R2y8zOBDDoxLeVTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HMBfWCgt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso30799455e9.0
        for <cgroups@vger.kernel.org>; Mon, 13 Jan 2025 05:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736775297; x=1737380097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QjR8z4REehx/8ZFb4vUXNWl5v6Zuh5ZvzSywNBFAF9U=;
        b=HMBfWCgtEoIHE8i5UuCchcHgTgrAIMzSze5E2bdsQEx1kH1jUfIoCMw5UaQbbRt3ar
         5ehbjTlStbfRcSvRqaNEdfoP6V23sohPuUpZC4K91BaVis07z28ZXE+0+C4+BBUynEpn
         R0cPHfRjAkBzxm/nThYAECNI8VRQn0uDiIxmRW+u5ni5V1Jf12Zd/qs4ARw5dZ6t2D4B
         PSQcVEXxpz5vnf88qvTpEYufJdcAaCx2vZnfILvbKqdAWZ4dty6VlfwpdTR28T7HhE99
         km41TGVTSJlHDFsdHsJQl8iS3GRSM/FYIlrf66KisGcrhV/lQCdzjGTbxloKiHFnaFHu
         pQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736775297; x=1737380097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjR8z4REehx/8ZFb4vUXNWl5v6Zuh5ZvzSywNBFAF9U=;
        b=eHnBpVQYG6wkFKdEIff6D7mEnuue3UwZV/jRhD1Og7wv/XUa/RR2Wt02uvU8XR0GuC
         BDWWVijuIi6KBG0LD/q6b59W4iGk7zgNGOjQPxlCVBkgLyZeaQjhY8TRJZR3PsAY8lga
         cqlVg9g8vBUqfW0UCYP5lb31A3cKbw3/z6ZhZw142KNZIH+iaQbVX1O15n+UYg+v5nSC
         cvufeCLZf6H7RrxiuPYUrs+WwBXtTfMSq2V/NmEIN4NNhsMW7Dwh9de+/npkyHFwHILI
         JhIRfKqlNi3N/aLI8uWdJiB+th8bEOjkPuybkJIxchci5TtZjrpzkym4Z0gvGaTnkuU0
         LSRg==
X-Gm-Message-State: AOJu0Yzx8kO3qztOQPEHtHTUREvuIz8w/Av95APYt53qM/ppweLV1GYw
	80uzt0tl7m/OdFv5cdwZfbIu69tKQMe/PEpBMLq1RCfh4/qvOVIbyMDUYqxPhQ0=
X-Gm-Gg: ASbGnct12sJ05l9cuKsj5E/rhs6PRysaKN5hqQXxaZ5K1CDkjgLHxhVjm6TWdwLwjgA
	UWOt2MCfB2qbmBgI2NVZC0n3Kj0YTNOGyjNFfTGwe5uNZYp7iG0XqDK4VO78uSpFXIJo5lYSdD/
	u95/vjeXR6CJPnEUzQksmdyRkzq1GpKFW2X0VcfY40l4nYrZCIWbZrhEQ/GziRCemvwVKextWcA
	Fih6QRy/yo/v+5qlkhYfUlhq17CSJX6z8BSudx8BReDxw1YNeee4Qr183I=
X-Google-Smtp-Source: AGHT+IGROFRXbQ3x0TfaLCNDj4ES/TMCPoW7zUCnSnkPObf4lj/tKnqYLVQ1uiv5yvZMGxpGEkhJ3w==
X-Received: by 2002:a05:600c:5122:b0:432:d797:404a with SMTP id 5b1f17b1804b1-436e26ddee5mr72383315e9.22.1736775296819;
        Mon, 13 Jan 2025 05:34:56 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e03ffcsm142813845e9.20.2025.01.13.05.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 05:34:56 -0800 (PST)
Date: Mon, 13 Jan 2025 14:34:55 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Haorui He <mail@hehaorui.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hannes@cmpxchg.org, tj@kernel.org
Subject: Re: [PATCH] cgroup: update comment about dropping cgroup kn refs
Message-ID: <u24aq62nmro4agt2t4wuckrijfl4l3xa6i5wggxygjeq3sffom@wgt3kuwjd3qn>
References: <20250112144920.1270566-1-mail@hehaorui.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="udxlkglrjpt4yw3d"
Content-Disposition: inline
In-Reply-To: <20250112144920.1270566-1-mail@hehaorui.com>


--udxlkglrjpt4yw3d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup: update comment about dropping cgroup kn refs
MIME-Version: 1.0

Hello Haorui.

On Sun, Jan 12, 2025 at 10:49:20PM +0800, Haorui He <mail@hehaorui.com> wrote:
> the cgroup is actually freed in css_free_rwork_fn() now
> the ref count of the cgroup's kernfs_node is also dropped there
> so we need to update the corresponding comment in cgroup_mkdir()

It seems you've read through the comments recently.
Do you have more up your sleeve? (So that it could be grouped in one
comments changeset.)

Thanks,
Michal

--udxlkglrjpt4yw3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ4UWfAAKCRAt3Wney77B
SXfhAPwJ07HYrHCg2TdomLFVWeA9RT6+uVguCt0KSYZh2/W/wAEAtV+zhrzZKAi4
cfTxBgH2Z2jZsBMqpUmpu4HVZYrbVw8=
=1FZL
-----END PGP SIGNATURE-----

--udxlkglrjpt4yw3d--

