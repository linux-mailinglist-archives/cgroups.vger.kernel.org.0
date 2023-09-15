Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89E7A25AD
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 20:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjIOS1h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 14:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjIOS1S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 14:27:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79090210A;
        Fri, 15 Sep 2023 11:26:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fb85afef4so2370103b3a.1;
        Fri, 15 Sep 2023 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694802373; x=1695407173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlV13QwwEAoXGdo9jbQW+sodfxxDlcgtLnB5aE/tibY=;
        b=Zni0BN3MU3FgBGvb9E3SP8UfiOMf9LsjEgP83dBOE2MUiHd2kF91631DgiECWi9G3G
         9j6cwAMJAHFkZk9fACn0OTo1n3YhpW92uT/YtOP7G3in8xwKlQFifT8GJq/1UKAnuW44
         EJ8Mzthsm7LMHKHyT4SE5SBsyAQ09tHZtJnphTRBih9LHn+ouJ2JQGhgXAqEMpDogceR
         buXRPYOU/W5w8XvAmKV+8ISs6AkNedKfAXGpwdvvJXphQ+qHWd/dmz9GOyV1//ODiYP9
         kAe6dgEwd9UJysMP/sbShYe3oxKT7j1yHa2xprFX/UFP6/mJ0ExbR+0E8IaK/06YAv0a
         N7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802373; x=1695407173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlV13QwwEAoXGdo9jbQW+sodfxxDlcgtLnB5aE/tibY=;
        b=hl716tEuar995P5ylAE6em2gJEEc2G1F4JRKtmBWK/4jL0nvuXlwKz7ELds+jZa2Em
         vA62XoxWIf0pwRQVw6GG5Mo2fp3bzpAv8UcYJ51AXWXKhDstd4dUZccSPVfmlb/1G5vu
         BvbALalGO0zxlt9aawLv3j76OU+A9528CcfAgPeWIXfYiILC/Tvb6EYLWU5Cq8pMrkTb
         2wihf0rxWXQcNwPc3Z3RNIVoAHFycB6iEqlG5sA+M9B6CsAqNMVMfTJbGNzCgAF25mZU
         lqf5NlBehNNVGnPkOZNVzt2ejnafkfRfL9QTeaAUOLgV3YnP/p7pOLnFUJ/scuVtM7j/
         7A2w==
X-Gm-Message-State: AOJu0YwY3uahGfhnv3SORxa3R8V8bZ+U+olKeaPQaLA7xapfcwRxXheh
        Fl5JAHPtwUzsjcgnDPyTwQE=
X-Google-Smtp-Source: AGHT+IEqMCcAWfckYmxxeU2Sj/UxNQHkJCdGLgYJ6dp/hUPxjtXiHVuvj3MRaVl6RlD+VN1d2FvZgA==
X-Received: by 2002:a05:6a20:8f01:b0:152:6b63:f1e7 with SMTP id b1-20020a056a208f0100b001526b63f1e7mr3082123pzk.1.1694802372788;
        Fri, 15 Sep 2023 11:26:12 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id r11-20020a62e40b000000b006879493aca0sm3248207pfh.26.2023.09.15.11.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:26:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 15 Sep 2023 08:26:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com, zhiquan1.li@intel.com,
        kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com,
        anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
        yangjie@microsoft.com
Subject: Re: [PATCH v4 00/18] Add Cgroup support for SGX EPC memory
Message-ID: <ZQShw25UBVvVvjQo@mtj.duckdns.org>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913040635.28815-1-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 12, 2023 at 09:06:17PM -0700, Haitao Huang wrote:
> SGX EPC memory allocations are separate from normal RAM allocations, and
> are managed solely by the SGX subsystem. The existing cgroup memory
> controller cannot be used to limit or account for SGX EPC memory, which is
> a desirable feature in some environments, e.g., support for pod level
> control in a Kubernates cluster on a VM or baremetal host [1,2].
> 
> This patchset implements the support for sgx_epc memory within the misc
> cgroup controller. The user can use the misc cgroup controller to set and
> enforce a max limit on total EPC usage per cgroup. The implementation
> reports current usage and events of reaching the limit per cgroup as well
> as the total system capacity.

Minor nit aside, it looks fine from cgroup side.

Thanks.

-- 
tejun
