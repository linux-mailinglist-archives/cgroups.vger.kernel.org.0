Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A01F526B0D
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 22:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384071AbiEMURK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357601AbiEMURJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 16:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46DFD34658
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652473027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1LW72Jjy9MKnDZ4qBo9AkKccKnp0hdNYiyWQhDRqlzQ=;
        b=B433sUzKUUBK9ITqlH/5/OxjEcvHiHHB4W6K73gni4Cmkpyr7JzUGwxewIBSb5TOMGTbCL
        PfEEVUBOf7KhIDxi6niePZF18cmYyC4rJQXGS+JtkA1ofCfHB2Pe1hSilTpgKnEl+NDjyl
        u4yI+x2kjZDnfWwJrydnvuX7Rdv0XbI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-Vp2BTxdoPM2uN1KrJHTUzw-1; Fri, 13 May 2022 16:17:06 -0400
X-MC-Unique: Vp2BTxdoPM2uN1KrJHTUzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F1AC101A52C;
        Fri, 13 May 2022 20:17:05 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.240])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4902940D2820;
        Fri, 13 May 2022 20:17:05 +0000 (UTC)
Date:   Fri, 13 May 2022 16:17:03 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH] kseltest/cgroup: Make test_stress.sh work if run
 interactively
Message-ID: <Yn68vzyMIy4upGtq@lorien.usersys.redhat.com>
References: <20220513190928.676841-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513190928.676841-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 03:09:28PM -0400 Waiman Long wrote:
> Commit 54de76c01239 ("kselftest/cgroup: fix test_stress.sh to use OUTPUT
> dir") changes the test_core command path from . to $OUTPUT. However,
> variable OUTPUT may not be defined if the command is run interactively.
> Fix that by using ${OUTPUT:-.} to cover both cases.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  tools/testing/selftests/cgroup/test_stress.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_stress.sh b/tools/testing/selftests/cgroup/test_stress.sh
> index 109c044f715f..3c9c4554d5f6 100755
> --- a/tools/testing/selftests/cgroup/test_stress.sh
> +++ b/tools/testing/selftests/cgroup/test_stress.sh
> @@ -1,4 +1,4 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> -./with_stress.sh -s subsys -s fork ${OUTPUT}/test_core
> +./with_stress.sh -s subsys -s fork ${OUTPUT:-.}/test_core
> -- 
> 2.27.0
> 


Thanks Waiman!  I did not think to try manually running it.


Cheers,
Phil

-- 

