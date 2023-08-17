Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBB077FD91
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354205AbjHQSMo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 14:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354235AbjHQSMc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 14:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3066273C
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692295911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rTErNomPttgl/viRXoYlofNYirDpLy640wteux782+8=;
        b=H2s7/44d0dwcKfK1FaYnYVPpi1C3dnf6s1vELPKSPF0jS+PUteVHlA4BHZqn+0cMsSMcOS
        vRY7GMd5ZSwawPS598n0P+38dbvMckW8gOU84DWqzyaRWtBP6fud2FDXXhWIU2gGaFPAci
        06t4cSYoyZTYoNyqLdVcxPRqHlsaodA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-qsuT6T7uNp2AG7_FGupEmA-1; Thu, 17 Aug 2023 14:11:49 -0400
X-MC-Unique: qsuT6T7uNp2AG7_FGupEmA-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56c7c54c25fso154362eaf.2
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 11:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692295908; x=1692900708;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTErNomPttgl/viRXoYlofNYirDpLy640wteux782+8=;
        b=HER1eAOq0NNIs1GkKIow5bnI5MNZlKJiwxBOE5li3AUmY+iCB3/3dSpuDtXmiPkTqy
         cYHK+BnIk0XGVDxifQRY+xzErppwh1T1ZW0vMDORrq+O6aZUlRBjlgG4qN8BiDMcMFDr
         ZzKiNHCZwklEAg0JgpodlcKBI43EwoN74Eafc5oPv2StJz2EwbTwhTtXuDXAOkKpEx3z
         /7Hayq5HVVM7CeVC/A00+uNRUcH5w/6WdB3rSFnck0HMwnzx5+89+PXuc9lXtdLm3rxD
         93KiMZjSRJV/V38RObEZz+85vsyy9EQu/GPWZxVbNZDC5wq+iOfNLcjfr7a8xT5foJJe
         scbg==
X-Gm-Message-State: AOJu0Yyp0FAcWFcMRS9yLjuN/s/mgRx7CaF+zHKIYHGYWTpfwl51DIbg
        oPP+23yyfF8PhYDxVqaixLPyIgIlROfCGsghipN8yzDt2xzEcblSEaB1tpJYX0c7YKDJYK3YmqJ
        UsCUK3e/FBV4gQYFPFg==
X-Received: by 2002:a05:6870:210f:b0:1ba:c622:3d5a with SMTP id f15-20020a056870210f00b001bac6223d5amr221684oae.18.1692295908798;
        Thu, 17 Aug 2023 11:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwERhgiG8BQEbAQpSqEJpeljF8hq9akQQFNWC+aNaxzMmCXPlOlMxrBacbtRCH+3VoEl22qg==
X-Received: by 2002:a05:6870:210f:b0:1ba:c622:3d5a with SMTP id f15-20020a056870210f00b001bac6223d5amr221663oae.18.1692295908583;
        Thu, 17 Aug 2023 11:11:48 -0700 (PDT)
Received: from fedora ([174.89.37.104])
        by smtp.gmail.com with ESMTPSA id p15-20020a0cf54f000000b0064721cf1535sm50551qvm.62.2023.08.17.11.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:11:48 -0700 (PDT)
Date:   Thu, 17 Aug 2023 14:11:38 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: cgroup: fix test_kmem_memcg_deletion
 kernel mem check
Message-ID: <nnxvxk23hrbr2rj2g5upbks6w766cgubhltfamvsto3mxidcxa@iovra4ubeq35>
References: <jnyjalhg43mdnn6su2a2kmwzqasdyjsfdvipim2i2hvqo7w6y2@st57sbo4bkxf>
 <20230817170702.mwem4nsy2ka4gj7n@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817170702.mwem4nsy2ka4gj7n@google.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 17, 2023 at 05:07:02PM +0000, Shakeel Butt wrote:
> On Thu, Aug 17, 2023 at 08:47:26AM -0400, Lucas Karpinski wrote:
> > The combination of using slab, anon, file, kernel_stack, and percpu is
> > not accurate for total kernel memory utilization. Checking kernel within
> > memory.stat provides a more accurate measurement.
> > 
> > Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> > ---
> >  v1: https://lore.kernel.org/all/eex2vdlg4ow2j5bybmav73nbfzuspkk4zobnk7svua4jaypqb5@7ie6e4mci43t/
> > 
> >  tools/testing/selftests/cgroup/test_kmem.c | 25 +++++-----------------
> >  1 file changed, 5 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> > index ed2e50bb1e76..3ef979ee0edf 100644
> > --- a/tools/testing/selftests/cgroup/test_kmem.c
> > +++ b/tools/testing/selftests/cgroup/test_kmem.c
> > @@ -166,7 +166,7 @@ static int cg_run_in_subcgroups(const char *parent,
> >   */
> >  static int test_kmem_memcg_deletion(const char *root)
> >  {
> > -	long current, slab, anon, file, kernel_stack, pagetables, percpu, sock, sum;
> > +	long current, kernel;
> >  	int ret = KSFT_FAIL;
> >  	char *parent;
> >  
> > @@ -184,30 +184,15 @@ static int test_kmem_memcg_deletion(const char *root)
> >  		goto cleanup;
> >  
> >  	current = cg_read_long(parent, "memory.current");
> > -	slab = cg_read_key_long(parent, "memory.stat", "slab ");
> > -	anon = cg_read_key_long(parent, "memory.stat", "anon ");
> > -	file = cg_read_key_long(parent, "memory.stat", "file ");
> > -	kernel_stack = cg_read_key_long(parent, "memory.stat", "kernel_stack ");
> > -	pagetables = cg_read_key_long(parent, "memory.stat", "pagetables ");
> > -	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
> > -	sock = cg_read_key_long(parent, "memory.stat", "sock ");
> > -	if (current < 0 || slab < 0 || anon < 0 || file < 0 ||
> > -	    kernel_stack < 0 || pagetables < 0 || percpu < 0 || sock < 0)
> > +	kernel = cg_read_key_long(parent, "memory.stat", "kernel ");
> > +	if (current < 0 || kernel < 0)
> >  		goto cleanup;
> >  
> > -	sum = slab + anon + file + kernel_stack + pagetables + percpu + sock;
> > -	if (abs(sum - current) < MAX_VMSTAT_ERROR) {
> > +	if (abs(kernel - current) < MAX_VMSTAT_ERROR) {
> 
> I don't think this is what you want. Since slab, kernel_stack,
> pagetables and percpu are included in the kmem stats, you just want to
> replace those with kmem. Basically keep the anon, file and sock stats.
>

Will fix and send new patch version.

Thanks,
Lucas

