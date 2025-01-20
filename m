Return-Path: <cgroups+bounces-6241-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066F2A16EE7
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2025 16:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737F71888111
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2025 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAE51B982E;
	Mon, 20 Jan 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y9baf5hl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76A1C2335
	for <cgroups@vger.kernel.org>; Mon, 20 Jan 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385266; cv=none; b=Ytl6MOPDBXUvoCCB4sW958W0VGTotMCr0Sob0wfwiPF/Gi8ZOdNOPJHQwBITbXzY7BaZ6kXeCd3NjKJCSkmtRZQL2aD+S4smGDSizla2SDA7S88zaEBgZmH3cPXxoV2lULmKF8M3Y6qG+UIUj0L0O7cksBJOLMiPw1a7F3y9Ktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385266; c=relaxed/simple;
	bh=asj/uimr+XiNatLrhqRCb8Vw8BsenYDGBmIhJD4sSzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYfaiTRTjgrsP7scQ9OL8Fm0slJbSnrS3qZ/XHSeZLBFVXbCib3jRWrGVgDMCQ2OegwOuYoFXGzlWCX+DkOSZXbBX8oiJlJvZl9cqvQDTA4v1/+qVIY2NQfdvdEBtw/pakgLH4IVhd3/bOSWiVJMSFnLvrngSMkgNe9q3IF7aC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y9baf5hl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so45471425e9.2
        for <cgroups@vger.kernel.org>; Mon, 20 Jan 2025 07:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737385263; x=1737990063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asj/uimr+XiNatLrhqRCb8Vw8BsenYDGBmIhJD4sSzc=;
        b=Y9baf5hlWBv47bP0pZ40/5haHndRR9npa0ttk0aPCzRcoETpMqRdyyyxQMcfO9UGEJ
         RzeEWkuvYf4w4usQ4nACuGAF2BqQ2lDZI2WsbXnqpcAjs9jHTkpeVTWKyjALzlRTb0Wp
         kIo2AnZGfciCzBgPj9p428y6hMcoP0MXJeSEmWU9kKYg3jbBqsTTVfBXKgeTJuuYZ1cJ
         h6hRuBf2cLP/VuyPEibT5VDXSj8hFVFkZr1a3wPIl9hs8UnfnR51zfRFQBVaw4Xvpeti
         97+A3RPZpIjJyf/kV5sIWWI6Alvd3lp8RhPIz/e7BNfbWQ7uQb2UhvomM1JBxZigdnNZ
         Dxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737385263; x=1737990063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asj/uimr+XiNatLrhqRCb8Vw8BsenYDGBmIhJD4sSzc=;
        b=op+SvNMTIdM+SH+MyJ1+yBnZExTSD8iWiLTiAY8Oy209WHrPQtCOByiDhNms0cy/3h
         WjUTSQuOS+1r08yG3HHuw/3AlwxfyYHMHXY/Hd6UgUZe7HFzKQwqNeOH1J+XzOr5QN/Y
         JnlJYdt7dzcZPTGnKJq1NtO2iYkbYwQq8gws2wPLbMYddbNO3DBb39u6GGOE6mO0JAEt
         jDaC4CRUkD53Kb5qYXoiyVeAbmGyGo/IE61rn2tuPUR3zQTC6/Fziskbf6NTpOri0A/g
         MNhHxN5lu80GOW1wgIgW9p4BdBNza/++r44JogYp0mrRuKbToRYNToV578Vc2YJzSdUz
         6oog==
X-Forwarded-Encrypted: i=1; AJvYcCX5hSc9+9sNd9jnbFPc/AO9inLrmjoGMMywOXcQsg6/4kmuMXErGLfc/vz27QHv22o5R3X8xIZ4@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5EoXuzlCzmkvJDq+/g6h1hH8GMirJrYK3cD7oN1JKxL08HcF
	lO78Sx0GN1n2HpZj35PtRfpjCRriCOHBV39NvmfN46A5YWP+Vx19wET3VYQ4q9c=
X-Gm-Gg: ASbGncugbW4ymGSRD87vaXTxk+5Ypdvta47PLInIpwg523qYO6JKKgm0uD9Qy1yGEnc
	oFuDGOwH+htoJz0LAMSAJ63sqYI++bAuZlM+0iIitW1m9FYPURLpOZGBpoHj2z4TDBbJUpzQk2h
	wsxPETHY0LR7IyBXz/73pfXEBMBihBqm8rbtMHbCrOc5xpO2diYafdbqLz+qxjY8FstImu7+Vdt
	weBGgP01zoVlqxCfg09+54cIE7bgQQFoVsyoMlkLlOOlrg/vpofXdFTgjATHACOti9UNsfG
X-Google-Smtp-Source: AGHT+IHU7IKibowjOp5iyupXGNYo2g1aNRGoxZ3HXz6UMwwnNHdlZwnc1ZpPxEGpBn2HUoDdjaC85w==
X-Received: by 2002:a05:600c:35c3:b0:438:a290:3ce0 with SMTP id 5b1f17b1804b1-438a2903f47mr75973505e9.8.1737385262801;
        Mon, 20 Jan 2025 07:01:02 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890408a66sm145066205e9.5.2025.01.20.07.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:01:02 -0800 (PST)
Date: Mon, 20 Jan 2025 16:01:00 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org
Subject: Re: [tj-cgroup:for-next 5/5] kernel/cgroup/cpuset-v1.c:397:18:
 error: implicit declaration of function 'cgroup_path_ns_locked'; did you
 mean 'cgroup_path_ns'?
Message-ID: <wb4pz2ny7hzg62j674tl5d24z72axasxpacivwx4mdbze44tcw@borj5ejhdwtt>
References: <202501180315.KcDn5BG5-lkp@intel.com>
 <4ea9fbd6-dc6d-499e-9110-461ed0462309@redhat.com>
 <Z4rHMAgNHCRRpss9@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5z7zzepdgysyonk4"
Content-Disposition: inline
In-Reply-To: <Z4rHMAgNHCRRpss9@slm.duckdns.org>


--5z7zzepdgysyonk4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [tj-cgroup:for-next 5/5] kernel/cgroup/cpuset-v1.c:397:18:
 error: implicit declaration of function 'cgroup_path_ns_locked'; did you
 mean 'cgroup_path_ns'?
MIME-Version: 1.0

On Fri, Jan 17, 2025 at 11:10:08AM -1000, Tejun Heo <tj@kernel.org> wrote:
> Dropped the patch for now. Michal, can you please send an updated version?

Sorry for complications. (Despite I tested both configs, I forgot about
some caching in my test setup and missed the build failure.)

I've sent out v3.

Michal

--5z7zzepdgysyonk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ45lKgAKCRAt3Wney77B
SVg5AQDUX7DDJhPSr5s2AMwlzl/3ZFdglJ9IXAd8MatXB35QWAEApeIyWJI4fyu1
rl2ZbAjeJZFo63mEJ4hIepFn42EySwk=
=7C1+
-----END PGP SIGNATURE-----

--5z7zzepdgysyonk4--

