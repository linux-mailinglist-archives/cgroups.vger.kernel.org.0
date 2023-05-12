Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084CC6FFFCF
	for <lists+cgroups@lfdr.de>; Fri, 12 May 2023 07:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjELFHA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 May 2023 01:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjELFG7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 May 2023 01:06:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01DC173C
        for <cgroups@vger.kernel.org>; Thu, 11 May 2023 22:06:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba69d93a6b5so4249259276.1
        for <cgroups@vger.kernel.org>; Thu, 11 May 2023 22:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683868017; x=1686460017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XEaR3Dr2C8Lj1JCkXuxURcDiSzXLw0/h58n+0eTFpXk=;
        b=h2TzF1Sm4wgRUFzC402/r2JRCTOK95t1n6LIDMbVzltdZxZ1uErK2N2BwmqWhMnZ2x
         gDJIw0J+ieOpsXu8IU+C+9duObCvbbPPNDpYL988Bbh3KOzpvj3WlzGRiCq3UgH/fKdN
         jnwqcwBkrJpjqMeb1gRz3IRnnjZdtsx6i43myLWpj4bq54RB0Rl+g5e4CVUWGbG7PuB/
         R7uGjC+ttKIstS0IoBo1yuXXZ2eT57tZ2egiGWEnJXomBv7Vlig+QVZOkQZLtcw28KJY
         LFbjerQqdZ+UkjE5fPUKDWc2gKvjdO5IUEWfiXlrRyC0zWLen+gMgJyctE6BqErCTj8Y
         hz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683868017; x=1686460017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEaR3Dr2C8Lj1JCkXuxURcDiSzXLw0/h58n+0eTFpXk=;
        b=iDbx9M8UeRH4+CKabEJo6oqtcP5I9xTcHASqk0GLOC4ZYbOKq75THyEi9+pIzI+A8Q
         78KPp2kOmZPCP4SZ73AHpv1IXUDvY361F9EMs2clNrCYL7QlQV6Yf3ZyfOnmAGqsZwMP
         atKY1L+cQ/XGV3w9nJrlUSLBS2EXQM/I1b9674LjyqhDlvbg97nh1G/fhroomuBF/qLJ
         ibWgKNWIO6aLPehKVuiTLS+nNuCfrJBntBLdJRzTRnEjEEByNTQwKD+9xBahxH/5O5Ig
         EDwzAjvMAzfdfmQhAMNvd6dObyDaL3fHyQr9agUa9/QwXGIgJ4m2iKCCH2eycNwYZ3zl
         dO7Q==
X-Gm-Message-State: AC+VfDwRYq8/1T9KNFvpntF40DDeaFlXxTXowCP6uxbfwo2rEa6efpdc
        egFIeIjQpB0Nl+idmNwfyJ6bdaoQaxy5Ig==
X-Google-Smtp-Source: ACHHUZ7DT3BCZCjNOk8XAjSIGAmryIlHycJZyc76A2YAWgJLUvsduVjlwCBoIYJxBL1Q7Z3AnsVenTZUavGcRg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:6b11:0:b0:b9d:a7a1:cab8 with SMTP id
 g17-20020a256b11000000b00b9da7a1cab8mr14344595ybc.7.1683868017143; Thu, 11
 May 2023 22:06:57 -0700 (PDT)
Date:   Fri, 12 May 2023 05:06:55 +0000
In-Reply-To: <CH3PR11MB7345F99927E27ED49EEFC6E5FC759@CH3PR11MB7345.namprd11.prod.outlook.com>
Mime-Version: 1.0
References: <CANn89i+J+ciJGPkWAFKDwhzJERFJr9_2Or=ehpwSTYO14qzHmA@mail.gmail.com>
 <CH3PR11MB734502756F495CB9C520494FFC779@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CALvZod4n+Kwa1sOV9jxiEMTUoO7MaCGWz=wT3MHOuj4t-+9S6Q@mail.gmail.com>
 <CH3PR11MB73454C44EC8BCD43685BCB58FC749@CH3PR11MB7345.namprd11.prod.outlook.com>
 <IA0PR11MB7355E486112E922AA6095CCCFC749@IA0PR11MB7355.namprd11.prod.outlook.com>
 <CANn89iJbAGnZd42SVZEYWFLYVbmHM3p2UDawUKxUBhVDH5A2=A@mail.gmail.com>
 <IA0PR11MB73557DEAB912737FD61D2873FC749@IA0PR11MB7355.namprd11.prod.outlook.com>
 <20230511211338.oi4xwoueqmntsuna@google.com> <CH3PR11MB734512D5836DBA1F1F3AE7CDFC759@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CH3PR11MB7345F99927E27ED49EEFC6E5FC759@CH3PR11MB7345.namprd11.prod.outlook.com>
Message-ID: <20230512050429.22du3gt6rrq6e37a@google.com>
Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a proper size
From:   Shakeel Butt <shakeelb@google.com>
To:     cathy.zhang@intel.com
Cc:     Eric Dumazet <edumazet@google.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
        kuba@kernel.org, Brandeburg@google.com,
        Brandeburg Jesse <jesse.brandeburg@intel.com>,
        Srinivas Suresh <suresh.srinivas@intel.com>,
        Chen Tim C <tim.c.chen@intel.com>,
        You Lizhen <lizhen.you@intel.com>, eric.dumazet@gmail.com,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 12, 2023 at 03:23:45AM +0000, Zhang, Cathy wrote:
> Remove the invalid mail addr added unintentionally.
> 

Sorry that was my buggy script.

[...]
> > 
> > Hi Shakeel,
> > 
> > Run with the temp change you provided,  the output shows it comes to
> > drain_stock_1(), Here is the call trace:
> > 
> >      8.96%  mc-worker        [kernel.vmlinux]            [k] page_counter_cancel
> >             |
> >              --8.95%--page_counter_cancel
> >                        |
> >                         --8.95%--page_counter_uncharge
> >                                   drain_stock_1
> >                                   __refill_stock
> >                                   refill_stock
> >                                   |
> >                                    --8.88%--try_charge_memcg
> >                                              mem_cgroup_charge_skmem
> >                                              |
> >                                               --8.87%--__sk_mem_raise_allocated
> >                                                         __sk_mem_schedule
> >                                                         |
> >                                                         |--5.37%--tcp_try_rmem_schedule
> >                                                         |          tcp_data_queue
> >                                                         |          tcp_rcv_established
> >                                                         |          tcp_v4_do_rcv
> 

Thanks a lot. This tells us that one or both of following scenarios are
happening:

1. In the softirq recv path, the kernel is processing packets from
multiple memcgs.

2. The process running on the CPU belongs to memcg which is different
from the memcgs whose packets are being received on that CPU.

BTW have you seen this performance issue when you run the client and
server on different machines? I am wondering if RFS would be good enough
for such scenario and we only need to worry about the same machine case.
