Return-Path: <cgroups+bounces-3110-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E691B8FDE26
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 07:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B2E1F256E5
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 05:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F32381C2;
	Thu,  6 Jun 2024 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BclufSjw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30DE19D890;
	Thu,  6 Jun 2024 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651981; cv=none; b=cS0ALPiIhA7SGoMV1BD/QXaClI3YYzcrtiMCQqoPnJazBFMMmrmId3pgDjj19ol7CAtE37Eq6g3NASUzFMtYaDOI/CaYwdGhGAPNvfSFNNdh8rzfRynn9B54QkcKwCV5R3jPsAxRq6NuFC2w8FgafPQoc75YUvWy+sKbFMBgDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651981; c=relaxed/simple;
	bh=TSW6rR7WfjTlrhH3HGcK56Ppf9/LdR0HR8fCehDZ0T8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=SsA0DJpYuaK/6PCi8NFliOn8xvglARx1HkDd4i8qpd+d7JECevHRyk9Q/pWmacc5cJ8BOsalwlHZCT/eJRUXHLRxFzsa5pK7DRaRDhtiQmOzTyKy/mJV7gLJD6w6WBHTmD6po/G6+1yT5cEsWC2G8r4W/eXULYw/UbECrqZQFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BclufSjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CF1C2BD10;
	Thu,  6 Jun 2024 05:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717651981;
	bh=TSW6rR7WfjTlrhH3HGcK56Ppf9/LdR0HR8fCehDZ0T8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=BclufSjwogBUg/aL6zgolQI/4j5p/iVtXcepfZowDpVf0aDy6FY8I3U4ONKNabF/2
	 ac5GE0LgIMfHgufF+l7v0uWx37MxiNr4NUw1FdxPJQMDRnsaDX5ra3St2GIfR0zhZq
	 LLSLdQLDPmErvHyaNBsC2UmT9L9unLS/6RZXfMrGFVgScbroe1zyCmc0g8YRuZICnV
	 7hrN5V2OrbiZdWWv7UPbRyChDhL80gI9RB2WFaHRSzgx21Os+oCWnu7dnr50KqY5oc
	 S6jKUDmn16mIBRBFi98DJEKYABAzFjvzucAkRFRRmvL3Nj9RU7j7ffZwBRnqoTKMWE
	 Jd0yFj/YTUrOg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Jun 2024 08:32:55 +0300
Message-Id: <D1SOT40TEXMI.A5J72PR5IWSP@kernel.org>
Subject: Re: [PATCH v14 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
X-Mailer: aerc 0.17.0
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-15-haitao.huang@linux.intel.com>
 <D1RKK8CENNXI.1KMNDADV9C1YM@kernel.org>
 <op.2owf5xiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2owf5xiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Wed Jun 5, 2024 at 6:33 PM EEST, Haitao Huang wrote:

> sgx_cgroup_try_charge() expects sgx_cg_wq, so it would break unless we =
=20
> check and return 0 which was the initially implemented in v12. But then =
=20
> Kai had some concern on that we expose all the interface files to allow =
=20
> user to set limits but we don't enforce. To keep it simple we settled dow=
n =20
                                              ~~~~~~~~~~~~~~

Sure:

"Keep it simple and corpse"

> back to BUG_ON(). This would only happen rarely and user can add =20
> command-line to disable SGX if s/he really wants to start kernel in this =
=20
> case, just can't do SGX.

Even disabling all of SGX would be a less catastrophical measure.

> Yes I had a comment but Kai thought it was too obvious and I can't think =
=20
> of a better one that's not obvious so I removed:

Not great advice given. Please just document it. In patch, which
BUG_ON() I don't want to see my R-by in it, until I've reviewed an
updated version.

BR, Jarkko

