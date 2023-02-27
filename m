Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BAA6A3B8F
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 08:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjB0HMm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 02:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjB0HMl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 02:12:41 -0500
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [IPv6:2001:41d0:203:375::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF91B56F
        for <cgroups@vger.kernel.org>; Sun, 26 Feb 2023 23:12:39 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677481955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xXaaQom8mDHJA5re/wVR2Gr6jNo+6nCEO59AZkZGfY=;
        b=YQ6T55nPIluDWjA7F/ABkTa/hvIEyIITBMl+BYge7MKBXtpPjKeaav/yH/nyegFcAdy1It
        Njw5j2fbdlxlq/cXhYoUb6O0hC8CRlTkWhaaKQwD3Qldsn3IU74l56Dc42xKPH5siSALBo
        2S931t/mSsJcW/99YGX8WnYZ4Mh+cPw=
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: cgroup: Add 'malloc' failures checks in
 test_memcontrol
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230226131634.34366-1-ivan.orlov0322@gmail.com>
Date:   Mon, 27 Feb 2023 15:11:54 +0800
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        lizefan.x@bytedance.com, shuah@kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Transfer-Encoding: 7bit
Message-Id: <8C12D50C-97D1-4969-9D02-290B1AB56C72@linux.dev>
References: <20230226131634.34366-1-ivan.orlov0322@gmail.com>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Feb 26, 2023, at 21:16, Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
> 
> There are several 'malloc' calls in test_memcontrol, which can be
> unsuccessful. This patch will add 'malloc' failures checking to
> give more details about test's fail reasons and avoid possible
> undefined behavior during the future null dereference (like the
> one in alloc_anon_50M_check_swap function).
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

