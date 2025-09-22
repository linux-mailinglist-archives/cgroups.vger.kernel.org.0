Return-Path: <cgroups+bounces-10369-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDCDB938AE
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 01:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8698446691
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 23:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDA3301025;
	Mon, 22 Sep 2025 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQezPU9i"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AAA21D3E6;
	Mon, 22 Sep 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758582604; cv=none; b=GNqCvUwbZh3C67U8GHy3rAzZ7hiu5VKrtLtR5iSHhpjROMoeU7qlTT0lwZ92Xv84/UqZMKYpHqsaIMLWtZXO1IeCwn5iWJ98ejDBApARbDhk4MVBdTToBrh9rApdaY7xa9XOuflf5QjM7fyYK+m2PcZ/qmCVdJOPBFQTg9LiM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758582604; c=relaxed/simple;
	bh=uXzEBNa32draPpqqEbmoU9ipexWgqGY6Nq8nMEu9FSQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=P8+TWpMY8jjUk3zPSD+q0BpF7X/NRQ1OeeqFGSuQkIAaE9o7AfQD3qPYA/WXuOnupA8iiD0y6LlvmiG4WwGedJwL2XqT3IWV7Slzsiq+XHul/PCh5PdTB4SijI6kQOt2gdmH+dKg/7uQrD40frN4PrxZts6/3N1lbYVZDGHkK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQezPU9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BECDC4CEF0;
	Mon, 22 Sep 2025 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758582604;
	bh=uXzEBNa32draPpqqEbmoU9ipexWgqGY6Nq8nMEu9FSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQezPU9irkuqQXELYyd53J+7uIr1hQDwUvSycixycsfBrBiZIR0XVj3N3Y58dskpJ
	 AY2DBl2SMLGQhSBe9F3+omofzIsAr8Iq35Yn5kNGrW9RKenujgO0Zj3CcqluUCTbMO
	 lwrY0jRrduAhx8vPrHa4vUk2Py6XCxKnE8qYzTkcununn1DL8q3zaZPumuRiOerCCq
	 CKwQUtUOF8bEEktx+m8KB/FmeGyKMfeXG9jZhEK7aJxXbSXKnjjaQSYsAcgiH97kJW
	 RfbN8+rGY5R3JSnqDbk0QZNbd1c5b9HD+2BR+oYPwrvJDsHvwfbFIXEAsJeNionpl5
	 dj6kdT0FnEuvg==
Date: Mon, 22 Sep 2025 13:10:03 -1000
Message-ID: <bff70a613775f72eeb8437a3b888c805@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>, longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH 0/3] cpuset: code cleanup and redundancy removal
In-Reply-To: <20250922130233.3237521-1-chenridong@huaweicloud.com>
References: <20250922130233.3237521-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

> Chen Ridong (3):
>   cpuset: remove redundant special case for null input in node mask
>     update
>   cpuset: remove impossible warning in update_parent_effective_cpumask
>   cpuset: remove is_prs_invalid helper

Applied 1-3 to cgroup/for-6.18.

Thanks.

--
tejun

