Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2371167A996
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 05:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjAYEWM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 23:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjAYEWL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 23:22:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8A053B01;
        Tue, 24 Jan 2023 20:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674620525; x=1706156525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NhOPx0gE0BklEYBntjw2S+n2t7urmONIUgn/cw4sNzQ=;
  b=cmZ/hpHuoi62xxIcTXpfAEozZ4cthOFFo5c8At44kqH5FJkVKQg54rPQ
   mtwrELPFObeZqdpgPpfgtW7gbsMwusud/pTS50NWnNQLiO3JOI6eYJ4wb
   6x1zKEtkulQbCwvApEFoR9t5/FN1zbVzDC/BDLK1uvadUDxtiybx0DYrW
   9v3uTyW/l2+86+kfxZmPXSQzdTfQrz5ubG2i7xIuB79oWz4N4OeACtAmr
   Pz1c05rwyy0Bx4F/iaGND6Q/R+/8U/83QgdRPVQDxHSVKnOT3Auy/vWga
   +AiStsNc94j+Xv6djwwIOGvfwMkWFB6P4yJsxXcTs4OTgfLL7UKOztDKl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="310052477"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="310052477"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 20:21:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="786312481"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="786312481"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2023 20:21:42 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKXI5-000720-1T;
        Wed, 25 Jan 2023 04:21:41 +0000
Date:   Wed, 25 Jan 2023 12:20:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        jeffv@google.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, cgroups@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] binder: Add flags to relinquish ownership of fds
Message-ID: <202301251234.klClMpZF-lkp@intel.com>
References: <20230123191728.2928839-4-tjmercier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123191728.2928839-4-tjmercier@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Mercier",

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 2241ab53cbb5cdb08a6b2d4688feb13971058f65]

url:    https://github.com/intel-lab-lkp/linux/commits/T-J-Mercier/memcg-Track-exported-dma-buffers/20230124-032017
base:   2241ab53cbb5cdb08a6b2d4688feb13971058f65
patch link:    https://lore.kernel.org/r/20230123191728.2928839-4-tjmercier%40google.com
patch subject: [PATCH v2 3/4] binder: Add flags to relinquish ownership of fds
config: x86_64-randconfig-a016-20230123 (https://download.01.org/0day-ci/archive/20230125/202301251234.klClMpZF-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/41e80f59d1b70691eefc0490e7f1df800cead9f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review T-J-Mercier/memcg-Track-exported-dma-buffers/20230124-032017
        git checkout 41e80f59d1b70691eefc0490e7f1df800cead9f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: dma_buf_transfer_charge
   >>> referenced by binder.c:2280 (drivers/android/binder.c:2280)
   >>>               drivers/android/binder.o:(binder_translate_fd) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
