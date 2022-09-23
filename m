Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA105E7AC0
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiIWM2y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 08:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiIWM2W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 08:28:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0D9148A0E;
        Fri, 23 Sep 2022 05:24:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F4B61AE4;
        Fri, 23 Sep 2022 12:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B140AC433D6;
        Fri, 23 Sep 2022 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663935852;
        bh=NM85qGkf1dVSLgcWZ9WS9hx6Yj3D92+rESK6H5VWGoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fuaO3gNn+VXn3Yxl+8JP0QCWQcdXn7r1h4B7zsIOiDer1BG7984BmGJSQPsTNW//R
         GtLPE9JShxRKCh/76id4IH1oGvbzS29V6Li1mS1kMqQRWnca/YdeTsoIWTGyHKu+AN
         GiRN/KA6ODjUVnLVP4TpFY5oG8GXYbEglfAR9Z9GmhYTXRZsn/3ntZSNXGKJorA2Pc
         gvnOG1u2zFwFltY670KLvDLgtP00wo2FMXCkFcQLWlGKhSht3jqDtYcT22ZV+nKbVX
         Ca23UEV0RhF78QZFWlJ3TjvSyDpg6drYseCHe6veVdWDFILxEHRbEqKb3GTDLwpDGH
         F+XHrJxuitqmg==
Date:   Fri, 23 Sep 2022 15:24:07 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 00/20] Add Cgroup support for SGX EPC memory
Message-ID: <Yy2lZx6u1dhFO34i@kernel.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922171057.1236139-1-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 22, 2022 at 10:10:37AM -0700, Kristen Carlson Accardi wrote:
> Add a new cgroup controller to regulate the distribution of SGX EPC memory,
> which is a subset of system RAM that is used to provide SGX-enabled
> applications with protected memory, and is otherwise inaccessible.
> 
> SGX EPC memory allocations are separate from normal RAM allocations,
> and is managed solely by the SGX subsystem. The existing cgroup memory
> controller cannot be used to limit or account for SGX EPC memory.
> 
> This patchset implements the sgx_epc cgroup controller, which will provide
> support for stats, events, and the following interface files:
> 
> sgx_epc.current
> 	A read-only value which represents the total amount of EPC
> 	memory currently being used on by the cgroup and its descendents.
> 
> sgx_epc.low
> 	A read-write value which is used to set best-effort protection
> 	of EPC usage. If the EPC usage of a cgroup drops below this value,
> 	then the cgroup's EPC memory will not be reclaimed if possible.
> 
> sgx_epc.high
> 	A read-write value which is used to set a best-effort limit
> 	on the amount of EPC usage a cgroup has. If a cgroup's usage
> 	goes past the high value, the EPC memory of that cgroup will
> 	get reclaimed back under the high limit.
> 
> sgx_epc.max
> 	A read-write value which is used to set a hard limit for
> 	cgroup EPC usage. If a cgroup's EPC usage reaches this limit,
> 	allocations are blocked until EPC memory can be reclaimed from
> 	the cgroup.

It would be worth of mentioning for clarity that shmem is accounted from
memcg.

BR, Jarkko
