Return-Path: <cgroups+bounces-12294-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43640CAE003
	for <lists+cgroups@lfdr.de>; Mon, 08 Dec 2025 19:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D6A130575A6
	for <lists+cgroups@lfdr.de>; Mon,  8 Dec 2025 18:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781532E92A3;
	Mon,  8 Dec 2025 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EUjXor5P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B38928312F
	for <cgroups@vger.kernel.org>; Mon,  8 Dec 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218936; cv=none; b=p0OULlCcjvqUje3+YZy/0regIRdBXpwjWctpCYSgvbGOvPW3CLcGl5j0HMQCc1titBUZ0IIgRmfdM/B42r4D3ILlKEdM04mM9X/O5yAJ6v//flFMt5SRsG4KjtqBlS/RSO0SOLauFpAtvcHz5h1RqfcTN+tfFMeKlzsCUfPlE/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218936; c=relaxed/simple;
	bh=Qps9e8mxRHn5MJbtOQUAtiSzK67T4F6kL2D7OJRig9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vonh7bySjbfchUPKF8fi4i6SS9JrK1Htmr9f/94dsh8H2x0vh1JtECfTLii3zOkhtX9jswo+0SZSChI4un7Bq8iluAWFqlmWIRzI/ezQVrvAlF8wjb+52iXkc6SfaXiGLDN4HP4TAQ6VGExRfS3kjItG5flmQcvwYTwz/r7OLtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EUjXor5P; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso63278295e9.0
        for <cgroups@vger.kernel.org>; Mon, 08 Dec 2025 10:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765218932; x=1765823732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wY2G3umTjO8QaTDkLQv7bCwYeE+8B+SB7EhcsgEzCs=;
        b=EUjXor5PgHsX8oJw2tIvP/6H4M3Y+IXCKf9tFA1uHJrxqKTvxh9C1/EE2c1MDh7RGh
         auq6sNZKugEIlW9hlO0mjG25csQSFoTHt0klzt64x1TfpnSDGfqinSPncu/8X24YAwlN
         +YAEjrI6QQnkplZVgjOVjvq2QJ/17lgaRbF7nwXvq2syleXRyqMZ6jsGLzskAx3gooGI
         Bem+D1HzI62zc8i89wk7bpP79ofyl3sUQczF5Y1tOeStjr34GXfH8JHgF/jQYFxU3ol/
         nS0VOcnZINqIVaqnYM+JRVNu92TwWG8csYOLggZitWdtIRJH+wLLjNOvSQ3mWcRZFheg
         M0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765218932; x=1765823732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wY2G3umTjO8QaTDkLQv7bCwYeE+8B+SB7EhcsgEzCs=;
        b=obqeNbIXlyRAxooL5Xpt6llDzo9oM5MU2SbsEPb11YnRqrEw9gAy+zEU4K074Nzxh6
         Qkm+jCBBE7LDi1nI5+kqVUF1LogwzdnDyRuRGesUIAXsi1o89CHaIKJroPbDJTX5dZ58
         eM62vGmEvyYGZsYv/8VBoj0jSCX4DZgqRi0yPmY3/KSketJ1VzJYw8d7BmydR/i92IcL
         kswv+sHlGF52Q/QRdidJxLEhlwk6CSA6xLfHfOwdWP/vhwsRF/mJVqHmE64zj9Hh1zsF
         fjdqpkPDm9HgG8p2RL81KrEcoax80K2Wy1ZaeVP5WZ+nWbxjR7KNtoFLnOIFusqBSiAL
         qmJA==
X-Forwarded-Encrypted: i=1; AJvYcCXxNCMi8zRGyvvWnVSCZ5wT0n3QG1JbbQBylVNxfCGA1Tm4PSZJ/h/47MQJNYUpKM7F1azkHBfl@vger.kernel.org
X-Gm-Message-State: AOJu0YwsxgFLW5OnhQatVxFbKZdqb0GNnEvBZynmmiOH2vbkColdAQGz
	wh6d8ILpY5453q9Ie4gDAJ2y3Yp+j1saSPAxv4Q2j7IPXiOQ8PBVBLGtUt2a6MhtqKw=
X-Gm-Gg: ASbGncv1mIO0DKsA96EXG/VuHi+uMdFaw4rZ0W/RJi8yv6aD/0zqAIv01haWtZiOt21
	9W5nH/rdVvVEdgs/f+L7QG3F+ewruK5rEA+KPospgPx8qYG4XVvLBWZekasiif9+0PUhTVCAegl
	etKgq7rquwz0u+33DKF1TMO2eg8f46GlB9xDQ45E8gTe0nR4z/hAAZ6W1YpXVo1qrk2RMctk2iC
	TztNYaPocmZM6YqxW6miDeDIzyp2OKLCruRF/J1c8rRg7SK0X0uLOmALnNoL2wcfrcv9gJmjA36
	2dMGcxuk1HZOnLgXEJ80mfwDGWIKFQkozSVRMSbnqTu19+iAReLCPnegIfGCLFnxCM0Y6xyAxy6
	GTWC845IsLQ+/5UvfCAXlGagEFigM0cHGPDR+MIuWoJ+aKykPBwb7/el7ImYv2AwkAhllx+Cc0X
	Nwwx4QfOuj8PgsuGgbw3ciC9BsktB3kaI=
X-Google-Smtp-Source: AGHT+IFG0X0Q1R93N8u/vWpDPDL2ng5Ky3tWYqQdQgUzDrHgsA9PHt4E0RmT1shTlNsMnNxjNNJR/A==
X-Received: by 2002:a05:6000:4028:b0:427:454:43b4 with SMTP id ffacd0b85a97d-42f89f56dcdmr8989533f8f.48.1765218932357;
        Mon, 08 Dec 2025 10:35:32 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7ca4f219sm25439566f8f.0.2025.12.08.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 10:35:31 -0800 (PST)
Date: Mon, 8 Dec 2025 19:35:30 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] cgroup: rstat: force flush on css exit
Message-ID: <hjxarrg2jy6cyy5hptjjbkop76jmb6mjdcazlcyqe6nnaoo3l7@7amn6gdssmeg>
References: <20251204210600.2899011-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gmi5fsjbdr4tg4xt"
Content-Disposition: inline
In-Reply-To: <20251204210600.2899011-1-shakeel.butt@linux.dev>


--gmi5fsjbdr4tg4xt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: rstat: force flush on css exit
MIME-Version: 1.0

Hi Shakeel.

On Thu, Dec 04, 2025 at 01:06:00PM -0800, Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> Cuurently the rstat update side is lockless and transfers the css of
> cgroup whose stats has been updated through lockless list (llist). There
> is an expected race where rstat updater skips adding css to the llist
> because it was already in the list but the flusher might not see those
> updates done by the skipped updater.

Notice that there's css_rstat_flush() in
css_free_rwork_fn()/css_rstat_exit().

> Usually the subsequent updater will take care of such situation but what
> if the skipped updater was the last updater before the cgroup is removed
> by the user. In that case stat updates by the skipped updater will be
> lost. To avoid that let's always flush the stats of the offlined cgroup.

Are you sure here that this is the different cause of the loss than the
other with unlocked cmpxchg you posted later?

> @@ -283,6 +283,16 @@ static struct cgroup_subsys_state *css_rstat_updated=
_list(
> =20
>  	css_process_update_tree(root->ss, cpu);
> =20
> +	/*
> +	 * We allow race between rstat updater and flusher which can cause a
> +	 * scenario where the updater skips adding the css to the list but the
> +	 * flusher might not see updater's updates. Usually the subsequent
> +	 * updater would take care of that but what if that was the last updater
> +	 * on that CPU before getting removed. Handle that scenario here.
> +	 */
> +	if (!css_is_online(root))
> +		__css_process_update_tree(root, cpu);
> +

I'm thinking about this approach:

@@ -482,6 +484,15 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
        if (!css->rstat_cpu)
                return;

+       /*
+        * We allow race between rstat updater and flusher which can cause a
+        * scenario where the updater skips adding the css to the list but =
the
+        * flusher might not see updater's updates. Usually the subsequent
+        * updater would take care of that but what if that was the last up=
dater
+        * on that CPU before getting removed. Handle that scenario here.
+        */
+       for_each_possible_cpu(cpu)
+               css_rstat_updated(css, cpu);
        css_rstat_flush(css);

        /* sanity check */

because that moves the special treating from relatively commonn
css_rstat_updated_list() to only cgroup_exit().

(I didn't check this wouldn't break anything.)

Thanks,
Michal

--gmi5fsjbdr4tg4xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTcabxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjUwgD/UQNbUH0dTJn/Ak6ywJAj
LkSAHi07EwnjGVgZNMs62TUA/RMxBqM3KNIPKEcYvfDpyhH6tzQJOOgGI29G1Ncx
RiUE
=BgfL
-----END PGP SIGNATURE-----

--gmi5fsjbdr4tg4xt--

