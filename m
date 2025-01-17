Return-Path: <cgroups+bounces-6237-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B4CA158D3
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 22:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5DB3A9605
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 21:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872A01A9B5C;
	Fri, 17 Jan 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awdtd5eN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E9187550;
	Fri, 17 Jan 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148211; cv=none; b=ZSTyuuHR1NdHQNaMN1mAzR9zSVMpxihA30SPG0mteYv63IgDJUrlWX+PHx1dL3f/1Nss9hvm4JxESHB5sT+A3rt+ek1DZw7uYwmz7O88zWEJUvzDW4wPP1Ep/P2z/lLN0sh38TrlJOJOoLLgSmKbXvi0ZcVAMlLsEy0J+3AcU/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148211; c=relaxed/simple;
	bh=80WaGNrMyxfNXZjSwoyfXLgx20wKhHJNV9j0Pqd2jq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbDv9GFBY7hAscjau0lj0c8YEvUdVSgJepv0EgPA3uNEHwzGpOEq52UQI/dzaopmhRhbeeQXehUuPk94utTmHdSpamUs5iwA1ysKrbJiou/9h8dmPyeXukreKjg1tjOCy2iv8my+cIEbEtOSYjL8U8XU8mHbM2dE37bQwf1Y2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awdtd5eN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FE1C4CEDD;
	Fri, 17 Jan 2025 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737148209;
	bh=80WaGNrMyxfNXZjSwoyfXLgx20wKhHJNV9j0Pqd2jq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awdtd5eNYYwIDtdGYEXiBB34qwHfEPakyKU7RXAJmIjtlrm5vqqSSX847eJBpLnMQ
	 MTIUp3rGSc9LiW29ql0Rblh35mVgIFB+gqfNCJmU/JiXusCrb2Kc23NwJJuZ986db8
	 yORb1WATcxyAi792vOIw+9V1pvTYNpqgvXfA+PuT68j2LRx3wRX92/SxqOr2nc3ljW
	 98IZPzFtblxVCj3KsvpmkBLjufL2KI4SRgAe0AA/9bCwu07CsnSb0a2S31TyArZ55n
	 Gbe9MDxSZJWbHVkkijHQgymYFEZJTuF17StL/hoJqIbyggldrgBcCQZ1ZqdmifjCx7
	 XjlQqLdy0oIoA==
Date: Fri, 17 Jan 2025 11:10:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: kernel test robot <lkp@intel.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org
Subject: Re: [tj-cgroup:for-next 5/5] kernel/cgroup/cpuset-v1.c:397:18:
 error: implicit declaration of function 'cgroup_path_ns_locked'; did you
 mean 'cgroup_path_ns'?
Message-ID: <Z4rHMAgNHCRRpss9@slm.duckdns.org>
References: <202501180315.KcDn5BG5-lkp@intel.com>
 <4ea9fbd6-dc6d-499e-9110-461ed0462309@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea9fbd6-dc6d-499e-9110-461ed0462309@redhat.com>

Dropped the patch for now. Michal, can you please send an updated version?

Thanks.

-- 
tejun

