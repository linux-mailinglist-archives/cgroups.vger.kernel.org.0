Return-Path: <cgroups+bounces-11201-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497CFC1166D
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 21:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A2B562A51
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE112798E5;
	Mon, 27 Oct 2025 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xuF9jbr+"
X-Original-To: cgroups@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE8221271;
	Mon, 27 Oct 2025 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597021; cv=none; b=pOtJLKM2ceHPMQauTgfdm67A7s4yEqzi29Txv3YOUwjpiV/I/agWuwNC2cWh/xRn1gK6AS32bCjtLPUyGbqNAnkgiDbygqv+oksZMhevqUCbUK05mn99tjsjuhCAIssyVhBp/YtY9GjdCISFypdn/zEgyZTQbaJfNCGLyiIEQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597021; c=relaxed/simple;
	bh=FpJksHKbNbnvuM32vTxDp/a0BiJVUCC+u81Tc7xWEwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXCjlPUq4mmP6WgOZBEM4M98kNgQIQm63V7JB/9+4XXtb+6ILe2Pu5czimS1U7Qaa9S37ai8YgBjuSkqRMPS1qMsuZziFYOxvR/z7U27t41UqpR3gjcL+f/1Y+CmCpiimYc/3C8yEqVPH8lIVtjHTNBx/0I1m5T7m//fSmcnuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xuF9jbr+; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cwQ9k2c9Gzm0yV6;
	Mon, 27 Oct 2025 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761597015; x=1764189016; bh=KO8bpDxbu7WSKjyCMrH9IItf
	cK9gHX5uW2abqkSIq70=; b=xuF9jbr+mxrV2zKATHmy1BefMfwp0aChdnfvPvIo
	HJsqF501HlhFuakmw9LaoziXSAujIock6P2YLQXUpI9372Xy3EKnEMyAJ4pJz+ik
	5vtebzT0ijgtQp5KtxUYzCf+TldvzfhiJpMNRgQYsyhVWqFZuT4Xck1Cx5LvdFud
	2ZoQenOhbCbe80GUn1Bn08nmfBISrECie8oHJnJlB3OxpbbDEWtoawaHoxFEp5tG
	qLciVcFBsKxnccRq/TYh46QHfEgsQfrjwjmhl4/K3pVhDyYEje6k44zrNjFUi+Tx
	ykfdpJs52zIaQcVuWZQa+sCVztp1pulJDd+GulnAVy1Q3g==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id F7m_iFspF2g7; Mon, 27 Oct 2025 20:30:15 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cwQ9R5JHlzm0yVL;
	Mon, 27 Oct 2025 20:30:01 +0000 (UTC)
Message-ID: <5c29fa84-3a2c-44be-9842-f0230e7b46dd@acm.org>
Date: Mon, 27 Oct 2025 13:30:00 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REPORT] Possible circular locking dependency on 6.18-rc2 in
 blkg_conf_open_bdev_frozen+0x80/0xa0
To: Nilay Shroff <nilay@linux.ibm.com>, David Wei <dw@davidwei.uk>,
 linux-block@vger.kernel.org, cgroups@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, gjoyce@ibm.com,
 lkp@intel.com, oliver.sang@intel.com
References: <63c97224-0e9a-4dd8-8706-38c10a1506e9@davidwei.uk>
 <5b403c7c-67f5-4f42-a463-96aa4a7e6af8@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5b403c7c-67f5-4f42-a463-96aa4a7e6af8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 9:54 PM, Nilay Shroff wrote:
> IMO, we need to make lockdep learn about this differences by assigning separate
> lockdep key/class for each queue's q->debugfs_mutex to avoid this false positive.
> As this is another report with the same false-positive lockdep splat, I think we
> should address this.
> 
> Any other thoughts or suggestions from others on the list?

Please take a look at lockdep_register_key() and
lockdep_unregister_key(). I introduced these functions six years ago to
suppress false positive lockdep complaints like this one.

Thanks,

Bart.

