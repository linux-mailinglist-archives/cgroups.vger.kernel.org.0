Return-Path: <cgroups+bounces-7225-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA61A6E1B2
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 18:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7BF7A35B8
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A86B265607;
	Mon, 24 Mar 2025 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LXMvqYGb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D8264FB3
	for <cgroups@vger.kernel.org>; Mon, 24 Mar 2025 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838559; cv=none; b=Yn/LZQ4drKXp2uk6gnYVlbC1PakiQHBK1Zq9MVndBl3dn4digG3ZLeqjqbg83KKMAEM02YyE+YjULmLo1cvB0ilEvaQN9Dm6zRksZDof8tO/jaXTdY4lqj7GLsV3LgMi2NRiWciYrsaUyb0lCWOv5ELrGZ5lJ7oQDvGEPBN08DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838559; c=relaxed/simple;
	bh=9s1UtFGW6J6OH02Hx3K3DMcL4m07GE7GlG86o53rNug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMdJE/YV698G3w4MReypGL7RgLFsxolhdV4jaI7huGazoj+p2rxhijAubTJuCNIFB3MONOfHCjE9H96U2adSM57oA+HNJGB28g58d/w4l6bO4AY83Z4fNYt9Y/sB4JEQB1YGQpy+1F8OsFoQAPw4qpbcOk0Bg7uw3aLr56vkFp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LXMvqYGb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2518336f8f.0
        for <cgroups@vger.kernel.org>; Mon, 24 Mar 2025 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742838555; x=1743443355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9s1UtFGW6J6OH02Hx3K3DMcL4m07GE7GlG86o53rNug=;
        b=LXMvqYGbqApxuAd+pn96Lsca0oJobLwbNzwb1+DsGqtRPy/nbyCcgFVPjevcGUn2if
         XMjxyeORTmYILWNeNLS/bsBCg4MYOdj+Yvm7g7TyqLSMlbxBf6GmFfupJsgJF8NFFfZZ
         V0mM7Vo+wij936UPRhXX/M9Z2h8GSG6sJZnUEjWBDsR5fhrUWmPOq1TjqDwfhsQ2HuJe
         XWYcGL5fWrl6I82c07Vhxa4Zvgn4wOO699lnxyckmWHsytXhixyB8kFy3pdm/XVOsA3H
         nymxBpnSw9Zz4XHfgHoF9N+IF4qNAw9NdqoGTm0qHrO6sUq8sr2B6UwHxsDNtrjB2YQ+
         W1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838555; x=1743443355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s1UtFGW6J6OH02Hx3K3DMcL4m07GE7GlG86o53rNug=;
        b=f7ZzP5WnVHsU1zcz7woOJAx+YY5SCKq6gtK3Cav0HMciqrhHBMv28U5jxZG/GV/eri
         YE1zo7GUfKDFKveMBkm7peNXju7cnJVMAVPnSq1p1lcogj+SR0oPA3jkxOEQZ/NsSiGe
         ZfYQN21UgAsqfbsYIgHNhKlaGRYbnYuDutbzsMLOslkqKrIpEgbKngbWIYY4MXtZbV/R
         QTxYqNouG5mn/zkUZRQDXkIxxRrAwo0WI71fM0TWxHu5gbSK/Z1BKeIhUizF7J+mZWlH
         alDzXpWHSfeqPWsI7Vu+DGm4TUQCHAD5I0o19/x8DhtRT9JWKCCSWagdHdq+RGPFr6sb
         aO4A==
X-Forwarded-Encrypted: i=1; AJvYcCWUvWLY+yUUjztFKLB+mnWeRRNFLz5/mEGORJpnWEIuu/iiSxnSM69EXJMGzrS0pmh59ojGkYj9@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3e3RKc3Fn3Eo/qDjBsH3TQ7ZUR85bv8+N9qhF/CtbvKVt7aF
	ixpF9hkuPhWgQ+oxugQ7y4Nn9crUsIFLASy1EEuu2RuRBpwbAp2lzvJamQTzzI0=
X-Gm-Gg: ASbGncvj5CE0W5wEf9Ei/5MlOgekufgx2pUR0+E5d1YC/e5jHmV0oOG2oDZwSDxcmsT
	X2OUjIMjJfsbg4y3Hf/zz98RzEg4IDxT5wyOWN50UYfHgtSuR1kkA1SH3LZ/DqfaZZ7agbPNFsE
	CKKLp4WaKTULGmgoLet36kU2VA3vvhXd5DxZQyVnCSmJcqWoXSa6phaf+vsORmrBQLyhsxDXNL1
	ROUPcSWhdv4Eml+rEgdUz0+GltqJiWB9SL0ToscTUJtnvPCDqaQqXiwoxeJrxlI9cSOWxNvV/Yg
	quQhhoDC96RGRxIjyhOlQwrCF7sq9U0tCYY+CO6g9v71dVY=
X-Google-Smtp-Source: AGHT+IFKIdJkgcPOjYK2onMS+G0viONx2v2z0cTwjpu9AmOQDm9Lchhrtjr5pI14oPRSjWDiCmfRvQ==
X-Received: by 2002:a5d:6d81:0:b0:391:29c0:83f5 with SMTP id ffacd0b85a97d-3997f94da3bmr12113949f8f.44.1742838555271;
        Mon, 24 Mar 2025 10:49:15 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef16csm11478577f8f.86.2025.03.24.10.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:14 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:49:13 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, shakeel.butt@linux.dev, 
	yosryahmed@google.com, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 4/4 v3] cgroup: save memory by splitting cgroup_rstat_cpu
 into compact and full versions
Message-ID: <k377dcki5jhhnndbjokcw5jt6dfv2t53ka3xvjbdje4ujc6mqe@macvktyakgu2>
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-5-inwardvessel@gmail.com>
 <Z9yMMzDo6L7GYGec@slm.duckdns.org>
 <5062846a-7b4d-4c59-a990-ae9f7fd624a9@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3kyzkk3sttxpmgqj"
Content-Disposition: inline
In-Reply-To: <5062846a-7b4d-4c59-a990-ae9f7fd624a9@gmail.com>


--3kyzkk3sttxpmgqj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 4/4 v3] cgroup: save memory by splitting cgroup_rstat_cpu
 into compact and full versions
MIME-Version: 1.0

On Fri, Mar 21, 2025 at 10:45:29AM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
> In general, I'll wait to see if Yosry, Michal, or Shakeel want any other
> changes before sending out the next rev.

Done.

Thanks,
Michal

--3kyzkk3sttxpmgqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+GbFwAKCRAt3Wney77B
SdTtAP0aL/fHTBlPxldTaYHYKRYqYm0zLbEK4xZ+kHEd6wXDeAD/a5sjnx8h11Pc
x+uVVjxmk514Ju3RDfMag0Bah4+EfQ0=
=bQ1E
-----END PGP SIGNATURE-----

--3kyzkk3sttxpmgqj--

