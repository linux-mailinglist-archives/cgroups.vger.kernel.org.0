Return-Path: <cgroups+bounces-14084-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGg9MfZWmWlvSwMAu9opvQ
	(envelope-from <cgroups+bounces-14084-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 07:55:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD8B16C4CC
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 07:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C3B03008320
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 06:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9935530BBA5;
	Sat, 21 Feb 2026 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGbwN+ib"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94D23ABBE
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771656945; cv=none; b=rF3VkiHbA7JSOmDx3Q4znb/j0L8rwPlEq45c/hJ0GQf5t2X7TtIoasSGXNFuEXCi3EXE9QOGLUcTr2CG3fw8e9q9JVxyCpGEIxtdZp08QW+gO1774eNQV4thMuyl9LRfOsGeSfPOzttGdEMlmssnK7QomptwQyqAid63MsL+hOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771656945; c=relaxed/simple;
	bh=ZN0uyNNt8mr/Y8GvzuhEG27BbBV3eSCx87RH7amlDto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIQHK/BW9JvNZMyjc2F48yfUzn6Wcy5YAbqJYo/FtSrXRjSZIlOujTUk8ltiu4kgj37kPmohuWJmbCjx+m8ttDen64N/JKDI1X3KcEjq++ild90c6lDCvj5SwnaPsTY7p0Rf5cTQxO4i9Sn7c9oQ68adh2tOKkNsFQfOPCgSBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGbwN+ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112F0C4CEF7;
	Sat, 21 Feb 2026 06:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771656945;
	bh=ZN0uyNNt8mr/Y8GvzuhEG27BbBV3eSCx87RH7amlDto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGbwN+ibYFtunsgKUvS3XDPPHfqAhLSSWbrguUkQfBTowOVatuHsw15HHfdr+scmz
	 n4zSd0fgjOWiiXD3ojLqeFXrROKAjkr5K4LGuCs4rzlBY4Node6brfzW2ozUKgZj6a
	 xuxoAu2dcSssmnTGtdAUTEiGpC6mi3cTRmhxkx5xwdy+FlA5CyO0/c4TXhAI5dtRAP
	 u1Z+gyQt5ZzDAlg3/mWcVOiwR0BvpvG6WFqBN2bO4x+bw7awjN+8n5aSf2SWE4DsaT
	 X5WihY/xieCoiYX/b07lblfNYZxFvKnXbAGhSMabd+1WrcgkbawETktHH5bDYKmTig
	 8Rq8HIpTlUXyw==
Date: Fri, 20 Feb 2026 20:55:44 -1000
From: Tejun Heo <tj@kernel.org>
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH] cgroup: ensure stable pid sorting in cmppid()
Message-ID: <aZlW8InMu6s2_RYc@slm.duckdns.org>
References: <20260221034907.2110829-1-kaushlendra.kumar@intel.com>
 <aZk707rPX4DrQIWb@slm.duckdns.org>
 <LV3PR11MB8768B0A29D442DD409E6D8BEF569A@LV3PR11MB8768.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR11MB8768B0A29D442DD409E6D8BEF569A@LV3PR11MB8768.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14084-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 6BD8B16C4CC
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 05:45:03AM +0000, Kumar, Kaushlendra wrote:
> > Can you give examples of such an overflow? What values
> > would cause that?
> 
> pid_t is a signed 32-bit integer. Consider:
> 
>   a = 2147483647  (INT_MAX, 0x7FFFFFFF)
>   b = -1
> 
>   a - b = 2147483647 - (-1) = 2147483648
> 
> This overflows signed int32, wrapping to a big negative value.
> 
> In practice, pid_t values in Linux are positive

and limited to PID_MAX_LIMIT (4mil).

> , so this overflow cannot happen with real PIDs
> today. However, the subtraction pattern is a known
> antipattern for comparison functions, and using the
> three-way idiom is the safer.(less, greater and equal)

It's a bigger anti pattern to complicate code for non-existent problems.

Thanks.

-- 
tejun

