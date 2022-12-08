Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DCA6472CB
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 16:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLHPXq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 10:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiLHPXf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 10:23:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1917DAE61;
        Thu,  8 Dec 2022 07:23:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABCE761F79;
        Thu,  8 Dec 2022 15:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC53C433C1;
        Thu,  8 Dec 2022 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670513014;
        bh=idCwRT488yL9eQafPepk84N7F/WrASo1UWSfCAAbFG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ncWXiM9KckUoZIb8zK20yn/3n1qMXHjH2xlZcvApn3g2FXjU7txRmRsBO5+4bdOSo
         gtU6ryBOGe4fBII167x2z8fepeVF4yHJKGJtS3Myvmxkgwwa+qKtaF8Jw+5GddjcgR
         deORSKDglSqQGC9z0QMr/9WaAV2UqSqB0BpjC0LnYj4GOe4kPZrLcqbRyLHAz7XgJl
         ytDMD9fjwv6lvdq6nKUlgXVwj2qHphNTM1/Jae4akC5/i/TM48JNXFw8LOHQqjXd/B
         5VYN2QB76cBVIfDZukrNL5xbojYwkYZd96DXKDR/8m1ITVESpkzdqEa8EsLk/8KC/0
         481BlWNmi8VNA==
Date:   Thu, 8 Dec 2022 15:23:29 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, zhiquan1.li@intel.com
Subject: Re: [PATCH v2 16/18] cgroup/misc: Prepare for SGX usage
Message-ID: <Y5IBcW6pF13pIqUp@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-17-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183655.3767674-17-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

"Prepare for SGX usage"?
 
What does that mean? Please make up something more descriptive.

BR, Jarkko
