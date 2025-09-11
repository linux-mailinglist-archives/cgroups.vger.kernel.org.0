Return-Path: <cgroups+bounces-9975-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB6DB5261C
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 03:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26EA07B86CD
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 01:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392C5212B0A;
	Thu, 11 Sep 2025 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xaqi1Qkr"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034D16DC28;
	Thu, 11 Sep 2025 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555539; cv=none; b=Vw7emOpxVa9hevAn0T0+r6zvZItLHV5BJ2rG6qbSNU2pzmZKklFhr3srwbFyb1PmF4aD4Va8PCW4/O5711OeFhiI0djR+6RpW72AT+t9nEUtcH6ptSqzRP4tmu1wvzrYaMdWvhsYmqxhisG4e2tqF9CXXtTJ9gci0+RaMR1cY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555539; c=relaxed/simple;
	bh=g+t7bFwL84+gT/aKYeuG5sdduFMechHlTeuCmtGkJUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwGd6h8vvwjEy8JErdfiZQmQYYTZ6nlVBDlC8wGoZ229Cl7Xiof4wSgMiTSxDTwJTsegRvFL7wQ/cedwLAylMXFovggWuaq/FfuvRSGzwj/5VWh2oioW7QVtqCSQJl/lUtW+Jz9L4RDog0cWGMDri9KSH1T52tjorp4P8wj8WR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xaqi1Qkr; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757555533; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=g+t7bFwL84+gT/aKYeuG5sdduFMechHlTeuCmtGkJUY=;
	b=xaqi1Qkr2w/D4ZyqUI+YXxoh30LxujisvztjypYCl6HUATrPrB0IBPUjOa/yKNqQLTp4MY1KUQ141VpUGIejsApx8B2klXqoV2A2F/cnacptNOQyeQvSUinfy9Rrwn8NjjlcMY1klJ1sqo+8O5+DpSQLDeB5HILnHghb4lTF6F0=
Received: from 30.221.147.222(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0Wnk0Zbj_1757555532 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Sep 2025 09:52:13 +0800
Message-ID: <8844ae9d-8af8-482f-a76d-8222d6ce9347@linux.alibaba.com>
Date: Thu, 11 Sep 2025 09:52:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] cgroup: replace global percpu_rwsem with per
 threadgroup resem when writing to cgroup.procs
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1757486368.git.escape@linux.alibaba.com>
 <9d46438e61bcf7b5ffc9eb582081f4fcc99c2cbf.1757486368.git.escape@linux.alibaba.com>
 <aMG5ucVGwlVLl4a_@slm.duckdns.org>
From: Yi Tao <escape@linux.alibaba.com>
In-Reply-To: <aMG5ucVGwlVLl4a_@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for the review and guidance.

