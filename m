Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32387496270
	for <lists+cgroups@lfdr.de>; Fri, 21 Jan 2022 16:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351411AbiAUP5I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jan 2022 10:57:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55052 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350816AbiAUP5I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jan 2022 10:57:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D333B1F3CA;
        Fri, 21 Jan 2022 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642780626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iC6HlJNGkj7g2fm9s+Lr372ZTXnke169KUBr6T9jAO8=;
        b=ZNv1nepTtadpjK+r7+JhnENvQ6TcqTpdwfnTtrIiHTVFtTqy4jVVmzuSRhdWIUpSZSa8aA
        +4PPzQVCBYGQ/Eate+TkuHoSkREYhXKdrjqDMHkAvQWcvteVPpx0svJ2Zj40GDAwoytb8k
        MBO/d/1QMWW39ZUAiejRHNbYnRApeao=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC1BD13A1E;
        Fri, 21 Jan 2022 15:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bEdzKdLX6mHvEwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 21 Jan 2022 15:57:06 +0000
Date:   Fri, 21 Jan 2022 16:57:05 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        matthltc@us.ibm.com, bblum@google.com, menage@google.com,
        akpm@linux-foundation.org, longman@redhat.com,
        zhaogongyi@huawei.com
Subject: Re: [PATCH] cgroup/cpuset: Fix a race between cpuset_attach() and
 cpu hotplug
Message-ID: <20220121155705.GA2394@blackbody.suse.cz>
References: <20220121101210.84926-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121101210.84926-1-zhangqiao22@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 21, 2022 at 06:12:10PM +0800, Zhang Qiao <zhangqiao22@huawei.com> wrote:
> Fixes: be367d099270 ("cgroups: let ss->can_attach and ss->attach do whole threadgroups at a time")

What a deep stratigraphy (not sure if it's this one but anything else
would likely come from eras ago too).

> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
>  kernel/cgroup/cpuset.c | 2 ++
>  1 file changed, 2 insertions(+)

Feel free to include
Reviewed-by: Michal Koutný <mkoutny@suse.com>

