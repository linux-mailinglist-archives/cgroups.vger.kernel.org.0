Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5640A79B1AE
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 01:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377485AbjIKW0f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 18:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244045AbjIKSz6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 14:55:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0161B6;
        Mon, 11 Sep 2023 11:55:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fba57030fso1321210b3a.3;
        Mon, 11 Sep 2023 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694458553; x=1695063353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4v+SVoqNGZrG3L1cc4+LLVgiWOB/yAKVlnaBwPQuJw=;
        b=fz1HmgzBMAHgvVObDmRvxhxfYOheslakSWVMIuXQb011jPTOl0M8vxXl4WKNFkOsQD
         ABO1fQ7V1zR6uvTo8XcYn7zoMwjuohsnNtr3OUmiRm7/O4oAwsMcgKzrB0LxlcdfrYwq
         FqNQQuc8WNJULf8A2ELczvMXnHRuJjR84m13WEm42SdLBKF97ZUGszojL1jj+gMg+61y
         2HJ3R7IZEmfOLIL5bR6lwSTwC0byNROG69BI4VjQE4OOL1JuIrGzYQe1SAL4o3OI4Dv8
         8Z0F9wXREizzvRpa84Whr1NpWUpPAVGBXD7wqrbsfv3Q8NX+gBufmtVQM727R6jXXrc9
         y0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694458553; x=1695063353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4v+SVoqNGZrG3L1cc4+LLVgiWOB/yAKVlnaBwPQuJw=;
        b=iGl6R8oH7SAylUSlDlyCnVxp9Jwi/kcisKrBZ8+d1LK5F6YaOSRjowLMhj1zMEA9m9
         U3C5ATC8iJnS5xQCwkJzM+a4weeLXAo8KCW+gwj1tl1kaErPZbQQFSHPVX4rSrAfVgr2
         MVBlgHY+U91vDjjwwm538sJuS4kFttZVc59Wkv3XGxRqjiGldy3I7KnVQKYb2snnstkL
         t5Qc06pL5iyBDiemwuZpsqcFngtz2S3hnyZnrEEUsU/20kjBtrdp6b3U2OjNvd0H5zIo
         icIsO9kcgmg75CIuhq8dIePhx2zJS9P0BuBpycw+iv3wu/Z0EADyEo2Y5XOSMRWIm9oe
         LKIQ==
X-Gm-Message-State: AOJu0YzMXmK+jqH+lv+rsYfClWixm8xSzh37Y4+Tada0/Y7Vi5TB+Ivd
        dscrQ74HJ9o/R6xt/FnHRYsMYOjWxa/eDA==
X-Google-Smtp-Source: AGHT+IEorBOJmt+LDA4QY7gxpy//vazvi1cD7qOl3PDBlyGrzPrLA6zDS+OwMSagdNQj9a2OZaemfQ==
X-Received: by 2002:a05:6a20:842a:b0:134:9f4e:623f with SMTP id c42-20020a056a20842a00b001349f4e623fmr10184955pzd.14.1694458553196;
        Mon, 11 Sep 2023 11:55:53 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7800a000000b006661562429fsm6085648pfi.97.2023.09.11.11.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 11:55:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 11 Sep 2023 08:55:50 -1000
From:   "tj@kernel.org" <tj@kernel.org>
To:     "Yakunin, Dmitry (Nebius)" <zeil@nebius.com>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        NB-Core Team <NB-CoreTeam@nebius.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [RFC PATCH 1/3] cgroup: list all subsystem states in debugfs
 files
Message-ID: <ZP9itivlZQIb5wZ0@mtj.duckdns.org>
References: <20230911075437.74027-1-zeil@nebius.com>
 <20230911075437.74027-2-zeil@nebius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911075437.74027-2-zeil@nebius.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 11, 2023 at 07:55:15AM +0000, Yakunin, Dmitry (Nebius) wrote:
> +static void mem_cgroup_css_dump(struct cgroup_subsys_state *css,
> +				struct seq_file *m)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +
> +	seq_printf(m, "mem_id=%u memory=%lu memsw=%lu kmem=%lu tcpmem=%lu shmem=%lu",
> +		   mem_cgroup_id(memcg),
> +		   page_counter_read(&memcg->memory),
> +		   page_counter_read(&memcg->memsw),
> +		   page_counter_read(&memcg->kmem),
> +		   page_counter_read(&memcg->tcpmem),
> +		   memcg_page_state(memcg, NR_SHMEM));
> +}

Can you please take a look at drgn (https://github.com/osandov/drgn) and see
whether that satifies your needs? We can easily add drgn scripts under tools
directory too (e.g. iocost already does that).

Thanks.

-- 
tejun
