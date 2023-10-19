Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D477CFF08
	for <lists+cgroups@lfdr.de>; Thu, 19 Oct 2023 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbjJSQGN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Oct 2023 12:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345210AbjJSQGK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Oct 2023 12:06:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E15B3;
        Thu, 19 Oct 2023 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697731570; x=1729267570;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=SlREd5rAEUIr1hUoGq+4u2bMdbm4gp8hOc98GrHIKzc=;
  b=Wp/gCMcvxeR10KjXSZY4XOGCPz9mab5GtZ/iH6uc4gIx9bTwAAqybh3o
   CTcObgWhQtIfLifNBOp1nvsYyZk95FqKW2RyQ9eVppN5jBvi8d9WCiB5Y
   Gxe9fdoiFMbXhMIyIQwqUcIcu8hm7FRBY5trEAf1pTkRxylAjEVhKRlD1
   Mg8583Hj/mw0RbLIZ7MGf1azOMiGe6MVaKS6Xh2Y5/JrLhw37crssFVic
   Rf/R4dhb0gN1SAmMYYC8SUQ+b5hnv7MRdtZvyVbL3g2I9A/rAi6219DQB
   iCqat+Nw7noxezcMqjEudXyHiQQRVgzSL+Vki4a50pXkKqIblA612AWzv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="4898559"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="4898559"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 09:05:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="930664073"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="930664073"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.92])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 19 Oct 2023 09:05:22 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com, zhiquan1.li@intel.com,
        kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com,
        anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
        yangjie@microsoft.com
Subject: Re: [PATCH v5 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-17-haitao.huang@linux.intel.com>
 <mc3js6ye7sw2z4gyppqwld7lepke5swqlfbx4mchqwxbwgwts3@c5vzusgelgyc>
Date:   Thu, 19 Oct 2023 11:05:18 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2c2ka4kwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <mc3js6ye7sw2z4gyppqwld7lepke5swqlfbx4mchqwxbwgwts3@c5vzusgelgyc>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 17 Oct 2023 13:54:54 -0500, Michal Koutn=FD <mkoutny@suse.com> w=
rote:

> On Fri, Sep 22, 2023 at 08:06:55PM -0700, Haitao Huang  =

> <haitao.huang@linux.intel.com> wrote:
>> +static void sgx_epc_cgroup_free(struct misc_cg *cg)
>> +{
>> +	struct sgx_epc_cgroup *epc_cg;
>> +
>> +	epc_cg =3D sgx_epc_cgroup_from_misc_cg(cg);
>
> It should check for !epc_cg since the misc controller implementation
> in misc_cg_alloc() would roll back even on non-allocated resources.

Good catch. Will fix.

>
>> +	cancel_work_sync(&epc_cg->reclaim_work);
>> +	kfree(epc_cg);
>> +}
>> +
>> +static void sgx_epc_cgroup_max_write(struct misc_cg *cg)
>> +{
>> +	struct sgx_epc_reclaim_control rc;
>> +	struct sgx_epc_cgroup *epc_cg;
>> +
>> +	epc_cg =3D sgx_epc_cgroup_from_misc_cg(cg);
>> +
>> +	sgx_epc_reclaim_control_init(&rc, epc_cg);
>> +	/* Let the reclaimer to do the work so user is not blocked */
>> +	queue_work(sgx_epc_cg_wq, &rc.epc_cg->reclaim_work);
>
> This is weird. The writer will never learn about the result of the
> operation.
>
Right. With the new plan, this callback will be removed.

Thanks
Haitao
