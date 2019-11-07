Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA0F2EB8
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 14:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbfKGNBq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 08:01:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:15470 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfKGNBq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 7 Nov 2019 08:01:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 05:01:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="gz'50?scan'50,208,50";a="233250644"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2019 05:01:41 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iShPy-0002Q0-2W; Thu, 07 Nov 2019 21:01:42 +0800
Date:   Thu, 7 Nov 2019 21:01:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     kbuild-all@lists.01.org, cgroups@vger.kernel.org
Subject: [cgroup:review-blkcg-rstat 2/6] block/bfq-cgroup.c:1245:15: error:
 'bfqg_print_rwstat' undeclared here (not in a function); did you mean
 'blkg_prfill_rwstat'?
Message-ID: <201911072105.HDGPiQdP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="76mvkez5eoratp34"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--76mvkez5eoratp34
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-blkcg-rstat
head:   f86f96284bcfa2446930adb116ee42788e43a571
commit: ca1d91e70679511777232393542c36736f74ec03 [2/6] bfq-iosched: stop using blkg->stat_bytes and ->stat_ios
config: s390-debug_defconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ca1d91e70679511777232393542c36736f74ec03
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> block/bfq-cgroup.c:1245:15: error: 'bfqg_print_rwstat' undeclared here (not in a function); did you mean 'blkg_prfill_rwstat'?
      .seq_show = bfqg_print_rwstat,
                  ^~~~~~~~~~~~~~~~~
                  blkg_prfill_rwstat
   block/bfq-cgroup.c:1288:15: error: 'bfqg_print_rwstat_recursive' undeclared here (not in a function); did you mean 'blkg_print_stat_ios_recursive'?
      .seq_show = bfqg_print_rwstat_recursive,
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
                  blkg_print_stat_ios_recursive

vim +1245 block/bfq-cgroup.c

  1226	
  1227	struct cftype bfq_blkcg_legacy_files[] = {
  1228		{
  1229			.name = "bfq.weight",
  1230			.flags = CFTYPE_NOT_ON_ROOT,
  1231			.seq_show = bfq_io_show_weight_legacy,
  1232			.write_u64 = bfq_io_set_weight_legacy,
  1233		},
  1234		{
  1235			.name = "bfq.weight_device",
  1236			.flags = CFTYPE_NOT_ON_ROOT,
  1237			.seq_show = bfq_io_show_weight,
  1238			.write = bfq_io_set_weight,
  1239		},
  1240	
  1241		/* statistics, covers only the tasks in the bfqg */
  1242		{
  1243			.name = "bfq.io_service_bytes",
  1244			.private = offsetof(struct bfq_group, stats.bytes),
> 1245			.seq_show = bfqg_print_rwstat,
  1246		},
  1247		{
  1248			.name = "bfq.io_serviced",
  1249			.private = offsetof(struct bfq_group, stats.ios),
  1250			.seq_show = bfqg_print_rwstat,
  1251		},
  1252	#ifdef CONFIG_BFQ_CGROUP_DEBUG
  1253		{
  1254			.name = "bfq.time",
  1255			.private = offsetof(struct bfq_group, stats.time),
  1256			.seq_show = bfqg_print_stat,
  1257		},
  1258		{
  1259			.name = "bfq.sectors",
  1260			.seq_show = bfqg_print_stat_sectors,
  1261		},
  1262		{
  1263			.name = "bfq.io_service_time",
  1264			.private = offsetof(struct bfq_group, stats.service_time),
  1265			.seq_show = bfqg_print_rwstat,
  1266		},
  1267		{
  1268			.name = "bfq.io_wait_time",
  1269			.private = offsetof(struct bfq_group, stats.wait_time),
  1270			.seq_show = bfqg_print_rwstat,
  1271		},
  1272		{
  1273			.name = "bfq.io_merged",
  1274			.private = offsetof(struct bfq_group, stats.merged),
  1275			.seq_show = bfqg_print_rwstat,
  1276		},
  1277		{
  1278			.name = "bfq.io_queued",
  1279			.private = offsetof(struct bfq_group, stats.queued),
  1280			.seq_show = bfqg_print_rwstat,
  1281		},
  1282	#endif /* CONFIG_BFQ_CGROUP_DEBUG */
  1283	
  1284		/* the same statistics which cover the bfqg and its descendants */
  1285		{
  1286			.name = "bfq.io_service_bytes_recursive",
  1287			.private = offsetof(struct bfq_group, stats.bytes),
  1288			.seq_show = bfqg_print_rwstat_recursive,
  1289		},
  1290		{
  1291			.name = "bfq.io_serviced_recursive",
  1292			.private = offsetof(struct bfq_group, stats.ios),
  1293			.seq_show = bfqg_print_rwstat_recursive,
  1294		},
  1295	#ifdef CONFIG_BFQ_CGROUP_DEBUG
  1296		{
  1297			.name = "bfq.time_recursive",
  1298			.private = offsetof(struct bfq_group, stats.time),
  1299			.seq_show = bfqg_print_stat_recursive,
  1300		},
  1301		{
  1302			.name = "bfq.sectors_recursive",
  1303			.seq_show = bfqg_print_stat_sectors_recursive,
  1304		},
  1305		{
  1306			.name = "bfq.io_service_time_recursive",
  1307			.private = offsetof(struct bfq_group, stats.service_time),
  1308			.seq_show = bfqg_print_rwstat_recursive,
  1309		},
  1310		{
  1311			.name = "bfq.io_wait_time_recursive",
  1312			.private = offsetof(struct bfq_group, stats.wait_time),
  1313			.seq_show = bfqg_print_rwstat_recursive,
  1314		},
  1315		{
  1316			.name = "bfq.io_merged_recursive",
  1317			.private = offsetof(struct bfq_group, stats.merged),
  1318			.seq_show = bfqg_print_rwstat_recursive,
  1319		},
  1320		{
  1321			.name = "bfq.io_queued_recursive",
  1322			.private = offsetof(struct bfq_group, stats.queued),
  1323			.seq_show = bfqg_print_rwstat_recursive,
  1324		},
  1325		{
  1326			.name = "bfq.avg_queue_size",
  1327			.seq_show = bfqg_print_avg_queue_size,
  1328		},
  1329		{
  1330			.name = "bfq.group_wait_time",
  1331			.private = offsetof(struct bfq_group, stats.group_wait_time),
  1332			.seq_show = bfqg_print_stat,
  1333		},
  1334		{
  1335			.name = "bfq.idle_time",
  1336			.private = offsetof(struct bfq_group, stats.idle_time),
  1337			.seq_show = bfqg_print_stat,
  1338		},
  1339		{
  1340			.name = "bfq.empty_time",
  1341			.private = offsetof(struct bfq_group, stats.empty_time),
  1342			.seq_show = bfqg_print_stat,
  1343		},
  1344		{
  1345			.name = "bfq.dequeue",
  1346			.private = offsetof(struct bfq_group, stats.dequeue),
  1347			.seq_show = bfqg_print_stat,
  1348		},
  1349	#endif	/* CONFIG_BFQ_CGROUP_DEBUG */
  1350		{ }	/* terminate */
  1351	};
  1352	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--76mvkez5eoratp34
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--76mvkez5eoratp34--
