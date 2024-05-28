Return-Path: <cgroups+bounces-3027-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BA08D253B
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 21:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45B128C00F
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 19:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3F5178399;
	Tue, 28 May 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY1zvV4m"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594E178CC3
	for <cgroups@vger.kernel.org>; Tue, 28 May 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925828; cv=none; b=s9CwLhbWAxD+Ooy9Z4owP8iUptUu3w+Shgnv54kMNaue9j12Jc2b6FzEpKwTBgYOFSJWJJz3aC0eJ4EnJASS+fVL7MCcXn1vRa0rxLgEQ9uMmKV/kpqIjLEYaQiZickJWhs23JCvoewFo5Bv6B5d0DLSR89KU2WvB7EIeUZsBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925828; c=relaxed/simple;
	bh=tzPr8Eb09GFk0ZuPoJgIJk0k4J+0i2WeMWKnh37deOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvXdYNvd0u8UrKjxbOpzT7CT55R5Hb1tpDnJPgU0nNyZP3hah76bINAchUgzamaPinCRkUB4+ScUwFOYJ++nkGzjvWhIHxm9Kuf5G16N8RoruVYqGhxiOfUYtiN0bUY89Utuvq6Jj7Si1RysI1KkCHj1coyTGXma3WM5h/euY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY1zvV4m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f47f0d8ec9so11766465ad.3
        for <cgroups@vger.kernel.org>; Tue, 28 May 2024 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716925826; x=1717530626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyW9e/v1pIEwAb5TemR0VWnnWzP07vqRLcWckuomv4o=;
        b=jY1zvV4myd95GZcI5aPC1T0pqmDIurQUkU7wYK4VCLUabCb8nYY1zoC4TUlX86Q6E6
         8TTvsPS96TvObGJgHe/fRjXjzxBPvEX14x9YGbMZuJkZVFo7vvirBih2r4Zc/P1EYEZB
         ZsLRkHKw+o1XTRcDBCLo1sXsO84/m7/iyqP7PeywQI7z7zpydFgOgpPBCnv4f/90D1a/
         q3STVKPOGlIHVGOcy6ONbTND1B7xVOpMFeg2SKMgzk+zkUzXXGmdfBMldibKpZWLSFNm
         CSZ/ZLqH61v0Iz9Yw4cBmChpgirxPNDeFZFFYOWzLs3b1jJeC1hw5GtkY4PL7JVViSkO
         YVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716925826; x=1717530626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyW9e/v1pIEwAb5TemR0VWnnWzP07vqRLcWckuomv4o=;
        b=UI2nNfIAWcVNiE4tVRVZOlxcyN9PzgagwvwLcP0RiFnStvZ5CiIO9rH003WaugQjn8
         Z0KybtT+zFlh5xPDtHZSpered2nPtC5K51bMG9R8T2hY2czjWHnzo/uSvz2PuM3wo8Mk
         K0mZOCkrPgzQcM4gCmtWqT8DzrZ3uTjmFnaHZJKlPwYrJvaWxyEkYORRVngFv3acl2t8
         2wCEidBnlk8+szQPbL8p3dWqPGwbbFAwSmIoJwtyXnUcb7w83lato+HhTYN52GvGooXB
         GG6CuXEg+ZWT5Rk387lL5bYPh+VjVk37K5PfILMlzp9LqTVQn34AsBF0TWRO+2T9GL1l
         HBwA==
X-Gm-Message-State: AOJu0YzGcs2pdYBHr+cBdqpQejV1nNtkghOeqBLI0mIrChlAj6RbpFv9
	Hte8Rg4T/Tg00oy+4eJ+8k1HlFsNB9Yzt0YIRUyuG0IMBtyTpPh1
X-Google-Smtp-Source: AGHT+IGw4SdnHhtTCMWG5plm8ThvQxcjGIK2gtMTBqE0gfnAiAicAjMoHbRr+nsl7bXf+IFydB+54w==
X-Received: by 2002:a17:902:6504:b0:1f4:9468:38b0 with SMTP id d9443c01a7336-1f4946839e6mr58247165ad.61.1716925826097;
        Tue, 28 May 2024 12:50:26 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f481d5a77bsm52568295ad.298.2024.05.28.12.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:50:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 May 2024 09:50:24 -1000
From: Tejun Heo <tj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: cgroups@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [tj-cgroup:for-next] BUILD REGRESSION
 a8d55ff5f3acf52e6380976fb5d0a9172032dcb0
Message-ID: <ZlY1gDDPi_mNrwJ1@slm.duckdns.org>
References: <202405271606.DYMCKs25-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405271606.DYMCKs25-lkp@intel.com>

(cc'ing loongarch folks)

On Mon, May 27, 2024 at 04:14:10PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
> branch HEAD: a8d55ff5f3acf52e6380976fb5d0a9172032dcb0  kernel/cgroup: cleanup cgroup_base_files when fail to add cgroup_psi_files
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/oe-kbuild-all/202405270728.d1SabzhU-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
> kernel/cgroup/pids.o: warning: objtool: __jump_table+0x0: special: can't find orig instruction
> 
> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> `-- loongarch-defconfig
>     `-- kernel-cgroup-pids.o:warning:objtool:__jump_table:special:can-t-find-orig-instruction

I don't know what to make of this build warning. I can't reproduce the
problem on x86 and the referenced commit doesn't have anything special. It
*looks* like it could be something specific to loongarch. Can you guys
please take a look?

Thanks.

-- 
tejun

