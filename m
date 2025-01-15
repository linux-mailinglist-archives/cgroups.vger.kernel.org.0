Return-Path: <cgroups+bounces-6163-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D5A11C6A
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 09:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2219B3A2BAC
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A41DE3D9;
	Wed, 15 Jan 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahtILrMU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2018A23F264;
	Wed, 15 Jan 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931034; cv=none; b=GUvZ1Gc2QUWSriwKOkm8wh2zkD1ucDO3rKnFq+k4rorsRRFE4FZmyVaiRbWdHwCdIAPBzlyw4zIfh08EuFqTJw2p3hok2lO39V02fOLHBx2j9q48DxEMtc4FRwxY4EBFZ4TUofdyWExgc5adJ95JcXE54+ZtA8+WoLVQm4n32EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931034; c=relaxed/simple;
	bh=foBUaGW4fuRofdxnTBj73G0WdM51+smJx2yDdUusg24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWh42zoZ/LqLKS6ihdUG1xVo9ZWyZ7k2wvylH7eBWqXdlUtr4txAwMGC1z8eNj0+xgV8G1r682ncSd/6sOTD69eN0pak4ZPWsUY+x2w3v+5uzGg9oTzRpzYuXewI7ggjDJqw0nmZV53hzMwcOQmc2Rk5aJjHA6FrsG8i6KvPzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahtILrMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834C5C4CEDF;
	Wed, 15 Jan 2025 08:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736931034;
	bh=foBUaGW4fuRofdxnTBj73G0WdM51+smJx2yDdUusg24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahtILrMUWntuEZA4G+xE81f0bseyBuxdNfbdW6CcjeNY4dPsO7xAuuxo5IonYe0Du
	 XB0PUZO2vveTrN3GXCOoUNyXu0FniyvNO66zcU/+qpFBvFg+zxlTgrAfNUQy6Y8d91
	 K2JYQJNPQbbU7CMsbImTj/JxPSuhUDsrXqbm8mEljG5kElO/PDl3pXVzdw2icZqi43
	 GYeT7+JGRntUVL9YDPTxGdV6vw6lJFukseWfqVnKUu2GzcnZgnqixyWa0VweB8ZQfL
	 RpybXIa19Gt0v2hUhOkOyVeZHuHe/qFqKXqenCXNCcfzezYTMGs8m4fw549fyYNPqR
	 9rPkR7nF3jI9A==
From: Maxime Ripard <mripard@kernel.org>
To: tj@kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] kernel/cgroup: Remove the unused variable climit
Date: Wed, 15 Jan 2025 09:50:27 +0100
Message-ID: <173693101809.2804074.2672495073642757354.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114062804.5092-1-jiapeng.chong@linux.alibaba.com>
References: <20250114062804.5092-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 Jan 2025 14:28:04 +0800, Jiapeng Chong wrote:
> Variable climit is not effectively used, so delete it.
> 
> kernel/cgroup/dmem.c:302:23: warning: variable ‘climit’ set but not used.
> 
> 

Applied to misc/kernel.git (drm-misc-next-fixes).

Thanks!
Maxime

