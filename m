Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0A848594A
	for <lists+cgroups@lfdr.de>; Wed,  5 Jan 2022 20:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbiAETh0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jan 2022 14:37:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38430 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243596AbiAETh0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jan 2022 14:37:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E69D221117;
        Wed,  5 Jan 2022 19:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641411444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JmOpUhpXVC0+uTu4AYIod3/yPSRbR+83ed8IY4Vyq4=;
        b=ND+G8iAgFF63f4CjEqcd/k6dT/sQPOuPsEqXaF0MgKqHF+WJAsAPueoPtTj1cNyQZdPM7J
        ln/8CvZM+cVH+EBetoT14A72SixoGUFdGNcRanbyzu6x3dYgJB0zhs/KRnAHaFtd32EAXs
        YRQuj1D0ghiTT233x3WjZuXdbuSpdx8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD68013C09;
        Wed,  5 Jan 2022 19:37:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Lf6eMXTz1WGXVwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 05 Jan 2022 19:37:24 +0000
Date:   Wed, 5 Jan 2022 20:37:23 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: rstat: explicitly put loop variant in while
Message-ID: <20220105193723.GE6464@blackbody.suse.cz>
References: <20211225000932.7253-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211225000932.7253-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 25, 2021 at 12:09:31AM +0000, Wei Yang <richard.weiyang@gmail.com> wrote:
> Instead of do while unconditionally, let's put the loop variant in
> while.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  kernel/cgroup/rstat.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Makes sense,
Reviewed-by: Michal Koutný <mkoutny@suse.com>

