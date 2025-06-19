Return-Path: <cgroups+bounces-8606-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C0AE0861
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 16:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3C73AB59E
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA327EC9C;
	Thu, 19 Jun 2025 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux8VJRHo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B721883F;
	Thu, 19 Jun 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342496; cv=none; b=TNnJxiz2/OYf7/HOQ3fgKedEtG5t//msvQ0S8+ojeqlHhQu/T54KU0sxTaiqhN2zRQmjgOPZj2e8pVWBUQeqsyRl3birvD1w5KfMSsM0h3ITbeb6KtIvFKiFaPnFzFnrda1gWcEEk8f2T4++GxfqiIeSoJFReJZAZ9MZhyzKV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342496; c=relaxed/simple;
	bh=fCJqpL7efJISFis1x+S69A7O2DZ2dP3W/xwnYArksBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlcNrIoxuPSpslYB9PfJvqI4HnGWcRBTJlzjEZKGzxHij9pe8kYYhpWqmSEw7O/RfyWNeZThU39yMLw+6NJFzMSEXtfRueT+AdLjqspn5+ImLUtelxtl+35SN6DNvxUZhLI3djZhTqvCziWfbxmIbCHG/l29H/Z2ahgYyj1WF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux8VJRHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6279C4CEEA;
	Thu, 19 Jun 2025 14:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750342496;
	bh=fCJqpL7efJISFis1x+S69A7O2DZ2dP3W/xwnYArksBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ux8VJRHottKVh6Dp4wwJSIxmRJaANX/JU4dOjhADbrJ6TV8qvrS9PaD5pHFB8+8Fl
	 R9QDgD7M/+CAC5tYs+xgunqBjH6OGvsil0iGliIPAvpj++dC5pUjNuEnNr1sRUlNcf
	 uDLdxy+qsSNv8eVsOSaMKj1Dmgh1DfcfhutaJgB/BHvuz+7R+YwDYUBE7Js0wBuwNi
	 D+eLD3+yOlqyVW1nKeWxDOy9k7EwAGrm7be2ghX3TpnKxSA+SUfrbu2wO4gkML3XNY
	 lSuXdHLVpmujLfWdzhWsRibY5P1g7o1LcfdPZvxbblVh9760uc7rCHUujz5HyMhRGj
	 0GJQtAtJhYkSA==
Date: Thu, 19 Jun 2025 07:14:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
 andrew@lunn.ch, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org
Subject: Re: [PATCH net v3] rds: Expose feature parameters via sysfs (and
 ELF)
Message-ID: <20250619071454.6a028c8d@kernel.org>
In-Reply-To: <20250618031522.3859138-2-konrad.wilk@oracle.com>
References: <20250618031522.3859138-1-konrad.wilk@oracle.com>
	<20250618031522.3859138-2-konrad.wilk@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 23:13:09 -0400 Konrad Rzeszutek Wilk wrote:
> We would like to have a programmatic way for applications
> to query which of the features defined in include/uapi/linux/rds.h
> are actually implemented by the kernel.

Hi Konrad, when you repost to fix Allison's comments please use 
  [PATCH net-next v4]
as the subject tag, [PATCH net] usually means fixes for current release.

