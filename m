Return-Path: <cgroups+bounces-2-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E847D3D00
	for <lists+cgroups@lfdr.de>; Mon, 23 Oct 2023 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC15B20F0A
	for <lists+cgroups@lfdr.de>; Mon, 23 Oct 2023 17:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4211D559;
	Mon, 23 Oct 2023 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BJsEmp5x"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991D1BDCD;
	Mon, 23 Oct 2023 17:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4BBC433C8;
	Mon, 23 Oct 2023 17:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698080578;
	bh=S4BUXYqW7MerdaHiLVRAwlqONWvs5nY4McI2oMjWThI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=BJsEmp5xvn1YBZsrWGBhdaTH8/3KAOQyicAzr1942Jy818Z9H+4FTi18RES0cQ+r4
	 nEBn+/HgO7vqRgjOQ6KL2PxOtIpEvc9W6pvU8NM3Uy2uULt4V7bTIuHulPCdNms3Cp
	 /eaV/PeLiVS3UWbd8wsVNbxr7e8mr2WL+Vkbym/w=
Date: Mon, 23 Oct 2023 13:02:56 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: audit@vger.kernel.org, autofs@vger.kernel.org, 
	backports@vger.kernel.org, ceph-devel@vger.kernel.org, cgroups@vger.kernel.org, 
	dash@vger.kernel.org
Subject: Re: This list is being migrated to new vger infra (no action
 required)
Message-ID: <20231023-cringing-salt-18e50b@meerkat>
References: <20231023-obscurity-bottom-1dc09c@meerkat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023-obscurity-bottom-1dc09c@meerkat>

On Mon, Oct 23, 2023 at 12:41:42PM -0400, Konstantin Ryabitsev wrote:
> This list is being migrated to the new vger infrastructure. This should be a
> fully transparent process and you don't need to change anything about how you
> participate with the list or how you receive mail.
> 
> There will be a brief delay with archives on lore.kernel.org. I will follow up
> once the archive migration has been completed.

Archive migration has been completed. Please reach out to helpdesk@kernel.org
if you notice anything not working correctly.

Best regards,
-K

